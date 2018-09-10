#!/bin/bash
# CASE 1

export WORKON_HOME=/home/sdn219/Envs
source /usr/local/bin/virtualenvwrapper.sh

WORKING_DIRECTORY="/home/sdn219/jace"
pushd $WORKING_DIRECTORY

ORCHESTRATOR_DIRECTORY=$WORKING_DIRECTORY/alto-orchestrator/orchestrator
DEMO_UTIL_DIRECTORY=$WORKING_DIRECTORY/demo-utils/utils
UNICORN_UI_DIRECTORY=$WORKING_DIRECTORY/UnicornUI

# pingall
workon unicorn
python $DEMO_UTIL_DIRECTORY/mock_zmq.py pingall
sleep 5
deactivate

# Configure network
pushd $DEMO_UTIL_DIRECTORY
./configure-all.sh
popd

# Start Unicorn UI
pushd $UNICORN_UI_DIRECTORY
workon unicorn
python setup.py install
gunicorn -b 0.0.0.0:4567 unicorn:app &
deactivate
popd

popd
