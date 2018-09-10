#!/bin/bash

CONTROLLER=$1

http_port=$(($1+8181))

shift

ports=""
for port in $@ ; do
    ports="$ports \"$port\""
done

ports=$(echo $ports | sed -e 's/ /,/g')

curl -v -u admin:admin http://127.0.0.1:$http_port/restconf/operations/alto-bwmonitor:bwmonitor-subscribe -H 'Content-type: application/json' -d '{"input":{"port-id":['$ports']}}'

