# This script is for configuring the EC2 server for sc18 demo

progress-bar() {
  local duration=${1}
    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}

WORK_HOME=$HOME

# This script shouldn't be called by root
username=`whoami`
if [ "$username" == "root" ]; then
    echo "This script shouldn't be called by root"
    exit -1 
fi

# The script may need root permission for some commands
echo "This script may need root permission for some commands"
root_result=`sudo echo "Got root permission."`
if [[ ! -n $root_result ]]; then
    echo "Sorry"
    exit -1
fi

pushd $WORK_HOME

# Prepare
echo "Installing needed packages"
sudo apt-get -qq update
sudo apt-get install -qq -y make build-essential python3-pip python-dev python-pip \
virtualenv virtualenvwrapper maven openjdk-8-jdk unzip

# Install mininet
git clone  --depth=1 --single-branch https://github.com/mininet/mininet && cd mininet && ./util/install.sh

echo "Creating a virtualenv named unicorn"
mkdir -p $WORK_HOME/Env
cd $WORK_HOME/Env
virtualenv -p `which python3` unicorn
UNICORN_PYTHON_INTERPRETER=$WORK_HOME/Env/unicorn/bin/python
echo "export UNICORN_PYTHON_INTERPRETER=$WORK_HOME/Env/unicorn/bin/python" >> ~/.bashrc
echo "Installing python packages to unicorn virtualenv"
$UNICORN_PYTHON_INTERPRETER -m pip install -q gunicorn flask falcon pyzmq # TODO: complete this

echo "Downloading OpenDaylight Oxygen SR3"
cd $WORK_HOME
curl https://nexus.opendaylight.org/content/repositories/public/org/opendaylight/integration/opendaylight/0.9.0/opendaylight-0.9.0.zip -o opendaylight-0.9.0.zip
unzip opendaylight-0.9.0.zip && mv opendaylight-0.9.0 opendaylight
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
echo "export ODL_HOME=$WORK_HOME/opendaylight" >> ~/.bashrc
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ODL_HOME=$WORK_HOME/opendaylight

echo "Installing openflow plugin"
$ODL_HOME/bin/start
progress-bar 30
echo "feature:install odl-openflowplugin-flow-services" | $ODL_HOME/bin/client -b
echo "feature:install odl-openflowplugin-southbound" | $ODL_HOME/bin/client -b
echo "Installing alto" # TODO:

echo "Installing alto-domain-agent"
cd $WORK_HOME
git clone --depth=1 https://github.com/openalto/alto-domain-agent
cd alto-domain-agent && mvn clean package -T 4 -DskipTests

echo "Installing unicorn orchestrator"
cd $WORK_HOME
git clone -b afm2018-case3 --depth=1 https://github.com/openalto/alto-orchestrator
$UNICORN_PYTHON_INTERPRETER -m pip install -q -r alto-orchestrator/requirements.txt

echo "Installing UnicornUI"
cd $WORK_HOME
git clone --depth=1 https://github.com/openalto/UnicornUI
$UNICORN_PYTHON_INTERPRETER -m pip install -q -r UnicornUI/requirements.txt