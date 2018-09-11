#!/bin/bash

IP=$1
PORT=$2

shift

ports=""
for port in $@ ; do
    ports="$ports \"$port\""
done

ports=$(echo $ports | sed -e 's/ /,/g')

curl -v -u admin:admin http://$IP:$PORT/restconf/operations/alto-bwmonitor:bwmonitor-subscribe -H 'Content-type: application/json' -d '{"input":{"port-id":['$ports']}}'

