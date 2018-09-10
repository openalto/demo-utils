#!/bin/sh

id=${1:-1}
name="unicorn"$id
config_folder="config_"$id
port1=$((6633 + $id))
port2=$((6653 + $id))
http_port=$((9000 + $id))
api_port=$((8181 + $id))
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
	fno2010/unicorn-server:odl-boron-sr4
