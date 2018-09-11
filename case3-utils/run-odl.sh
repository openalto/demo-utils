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
  opendaylight/odl:5.4.0 \
  /opt/opendaylight/bin/karaf
