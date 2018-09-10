#!/bin/bash
# CASE 1

sudo echo "Some commands need root permission"

export WORKON_HOME=/home/sdn219/Envs
source /usr/local/bin/virtualenvwrapper.sh

WORKING_DIRECTORY="/home/sdn219/jace"
pushd $WORKING_DIRECTORY

ORCHESTRATOR_DIRECTORY=$WORKING_DIRECTORY/alto-orchestrator/orchestrator
DEMO_UTIL_DIRECTORY=$WORKING_DIRECTORY/demo-utils/utils
UNICORN_UI_DIRECTORY=$WORKING_DIRECTORY/UnicornUI

# Start orchestrator
pushd $ORCHESTRATOR_DIRECTORY
workon unicorn
gunicorn -b 0.0.0.0:6666 app:app &
deactivate
popd

# Start unicorn docker
docker stop unicorn1
pushd $DEMO_UTIL_DIRECTORY
./run-unicorn.sh 1
popd
sleep 90

# Start mininet
sudo ./xdom-mn/bin/xdom-mn -c demo-utils/topology/basic.json --zmq-ip="0.0.0.0"
sleep 5

popd
