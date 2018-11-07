# Start Opendaylight
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
#ssh -t ubuntu@$SITE_A_IP $ODL_HOME/bin/start
echo "ATTENTION: For now, we cannot start opendaylight remotely. Please login to the server and start the opendaylight manually."
progress-bar 10

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

$ODL_HOME/bin/start
echo "Starting Opendaylight Service"
progress-bar 60

echo "Starting Alto-domain-agent"
cd $WORK_HOME/alto-domain-agent
nohup mvn jetty:run &

echo "Starting orchestrator"
cd $WORK_HOME/alto-orchestrator/orchestrator
$WORK_HOME/Env/unicorn/bin/gunicorn -b 0.0.0.0:6666 app:app &

echo "Starting Cross Domain Mininet"
sudo $WORK_HOME/xdom-mn/bin/xdom-mn -c $WORK_HOME/demo-utils/topology.json
