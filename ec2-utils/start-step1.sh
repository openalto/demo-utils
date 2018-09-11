#!/bin/bash

prog() {
    local w=80 p=$1;  shift
    local spin=$1;  shift
    # create a string of spaces, then change them to spins
    printf -v spins "%*s" "$(( $p*$w/100 ))" ""; spins=${spins// /$spin};
    # print those spins on a fixed-width space plus the percentage etc.
    printf "\r\e[K|%-*s| %3d %% %s" "$w" "$spins" "$p" "$*";
}

CASE=${1:-case3}

case $CASE in
  case1)
    TOPO=demo-utils/ec2-utils/basic.json
    ;;
  case2)
    TOPO=demo-utils/ec2-utils/basic.json
    ;;
  case3)
    TOPO=demo-utils/ec2-utils/interdomain.json
    ;;
  case4)
    TOPO=demo-utils/ec2-utils/interdomain.json
    ;;
  *)
    echo "Support option: {case1|case2|case3|case4}"
    exit 1
esac

sudo echo "Some commands need root permission"

export WORKON_HOME=$HOME/Envs
source /usr/local/bin/virtualenvwrapper.sh

WORKING_DIRECTORY=${WORKING_DIRECTORY:-$HOME/jace}
pushd $WORKING_DIRECTORY

ORCHESTRATOR_DIRECTORY=$WORKING_DIRECTORY/alto-orchestrator/orchestrator
DEMO_UTIL_DIRECTORY=$WORKING_DIRECTORY/demo-utils/ec2-utils
UNICORN_UI_DIRECTORY=$WORKING_DIRECTORY/UnicornUI

# Start orchestrator
pushd $ORCHESTRATOR_DIRECTORY
workon unicorn
gunicorn -b 0.0.0.0:6666 app:app &
deactivate
popd

# Start unicorn docker
$DEMO_UTIL_DIRECTORY/start-remote.sh $CASE
tt=180
step=$(echo "scale=2; $tt/100" | bc)

for x in {1..100} ; do
    prog "$x" "=" "starting unicorn server..."
    sleep $step
done ; echo

# Start mininet
sudo ./xdom-mn/bin/xdom-mn -c $TOPO --zmq-ip="0.0.0.0"
sleep 5

popd
