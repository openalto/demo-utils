#!/bin/sh

java -jar /home/ubuntu/alto-domain-agent/jetty-runner.jar /home/ubuntu/alto-domain-agent/target/unicorn-server &

/home/ubuntu/Env/unicorn/bin/gunicorn -b 0.0.0.0:8399 -w 4 sfp:app &