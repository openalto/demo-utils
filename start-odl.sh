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

