#!/bin/sh

cd $HOME/alto-domain-agent
nohup java -jar jetty-runner.jar target/unicorn-server &

cd $HOME/sfp-impl
nohup $HOME/Env/unicorn/bin/gunicorn -b 0.0.0.0:8399 -w 4 sfp:app &
