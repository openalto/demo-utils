#!/bin/bash

sudo pkill gunicorn
sudo pkill xdom-mn
ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn1 bash ~/stop-node.sh
ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn2 bash ~/stop-node.sh
ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn3 bash ~/stop-node.sh
sudo mn -c
