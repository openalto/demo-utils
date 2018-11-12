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
virtualenv virtualenvwrapper maven openjdk-8-jdk unzip jq

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

echo "Downloading OpenDaylight Oxygen SR2"
cd $WORK_HOME
curl https://nexus.opendaylight.org/content/repositories/opendaylight.release/org/opendaylight/integration/karaf/0.8.2/karaf-0.8.2.zip -o karaf-0.8.2.zip
unzip karaf-0.8.2.zip && mv karaf-0.8.2 opendaylight
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
echo "export ODL_HOME=$WORK_HOME/opendaylight" >> ~/.bashrc
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ODL_HOME=$WORK_HOME/opendaylight

echo "Waiting for ODL server on"
$ODL_HOME/bin/start
progress-bar 30
echo "Installing openflow plugin and alto-basic ..."
echo "feature:install odl-openflowplugin-flow-services" | $ODL_HOME/bin/client -b
echo "feature:install odl-openflowplugin-southbound" | $ODL_HOME/bin/client -b
echo "feature:install odl-alto-basic" | $ODL_HOME/bin/client -b
echo "feature:install odl-l2switch-all" | $ODL_HOME/bin/client -b
echo "kar:install https://raw.githubusercontent.com/openalto/demo-utils/sc18-demo-ec2/bwmonitor-feature/odl-alto-bwmonitor-0.1.2.kar" | $ODL_HOME/bin/client -b
echo "feature:install odl-alto-bwmonitor" | $ODL_HOME/bin/client -b

echo "Installing alto-domain-agent"
cd $WORK_HOME
git clone --depth=1 -b sc18-demo https://github.com/openalto/alto-domain-agent
cd alto-domain-agent && mvn clean package -T 4 -DskipTests
curl http://central.maven.org/maven2/org/eclipse/jetty/jetty-runner/9.4.9.v20180320/jetty-runner-9.4.9.v20180320.jar -o jetty-runner.jar

echo "Installing unicorn orchestrator"
cd $WORK_HOME
git clone -b afm2018-case3 --depth=1 https://github.com/openalto/alto-orchestrator
$UNICORN_PYTHON_INTERPRETER -m pip install -q -r alto-orchestrator/requirements.txt

echo "Installing UnicornUI"
cd $WORK_HOME
git clone --depth=1 https://github.com/openalto/UnicornUI
$UNICORN_PYTHON_INTERPRETER -m pip install -q -r UnicornUI/requirements.txt

echo "Installing cross domain mininet"
cd $WORK_HOME
git clone --depth=1 https://github.com/openalto/xdom-mn
cd xdom-mn
sudo pip install -q -r requirements.txt # Using system python2
sudo ./setup.py install
echo "export XDOMMN_HOME=$WORK_HOME/xdom-mn" >> ~/.bashrc
XDOMMN_HOME=$WORK_HOME/xdom-mn

echo "Installing alto-nova"
cd $WORK_HOME
git clone --depth=1 https://github.com/openalto/alto-nova
cd alto-nova
python3 -m pip install -q -r requirements.txt
sudo python3 setup.py install 

echo "Installing sfp-impl"
cd $WORK_HOME
git clone --depth=1 -b dummy https://github.com/openalto/sfp-impl
cd sfp-impl
$UNICORN_PYTHON_INTERPRETER -m pip install -q -r requirements.txt
$UNICORN_PYTHON_INTERPRETER setup.py install

echo "Add some alias"
alias gunicorn=$WORK_HOME/Env/unicorn/bin/gunicorn
echo "alias gunicorn=$WORK_HOME/Env/unicorn/bin/gunicorn" >> ~/.bashrc

# Put configs in right place
echo "Putting configs in right palce"
cd $WORK_HOME/demo-utils
# unicorn1
cp sfp-config/unicorn1/initial-rib.json ~/initial-rib.json # SFP
cp agent-config/orchestrators.json /home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/orchestrator/orchestrators.json # Orchestrators
cp agent-config/unicorn1/server.json /home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/server.json
cp agent-config/unicorn1/web.xml /home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/web.xml
cp agent-config/sc18.json /home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/adapter/sc18.json
cp agent-config/sc18.json /home/ubuntu/sc18.json

# unicorn2
scp sfp-config/unicorn2/initial-rib.json unicorn2:~/initial-rib.json # SFP
scp agent-config/orchestrators.json unicorn2:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/orchestrator/orchestrators.json # Orchestrators
scp agent-config/unicorn2/server.json unicorn2:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/server.json
scp agent-config/unicorn2/web.xml unicorn2:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/web.xml
scp agent-config/sc18.json unicorn2:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/adapter/sc18.json
scp agent-config/sc18.json unicorn2:/home/ubuntu/sc18.json

# unicorn3
scp sfp-config/unicorn3/initial-rib.json unicorn3:~/initial-rib.json # SFP
scp agent-config/orchestrators.json unicorn3:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/orchestrator/orchestrators.json # Orchestrators
scp agent-config/unicorn3/server.json unicorn3:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/server.json
scp agent-config/unicorn3/web.xml unicorn3:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/web.xml
scp agent-config/sc18.json unicorn3:/home/ubuntu/alto-domain-agent/target/unicorn-server/WEB-INF/classes/adapter/sc18.json
scp agent-config/sc18.json unicorn3:/home/ubuntu/sc18.json