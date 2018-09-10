#!/bin/sh

name="unicorn"$1
config_folder="config_"$1
port1=$((6633 + $1))
port2=$((6653 + $1))
http_port=$((9000 + $1))
api_port=$((8181 + $1))
sudo docker run -d \
	--name $name \
	--rm \
	-p $port1:6633 \
	-p $port2:6653 \
	-p $http_port:80 \
	-p $api_port:8181 \
	--entrypoint /docker-entry-point.sh \
	-v $(pwd)/docker-entry-point.sh:/docker-entry-point.sh \
	-v $(pwd)/$config_folder/web.xml:/opt/unicorn-server/WEB-INF/web.xml \
	-v $(pwd)/$config_folder/server.json:/opt/unicorn-server/WEB-INF/classes/server.json \
	-v $(pwd)/$config_folder/mock.json:/opt/unicorn-server/WEB-INF/classes/adapter/mock.json \
	-v $(pwd)/$config_folder/orchestrators.json:/opt/unicorn-server/WEB-INF/classes/orchestrator/orchestrators.json \
	-v $(pwd)/../alto-domain-agent/target/unicorn-server:/opt/unicorn-server \
	unicorn-server:latest
