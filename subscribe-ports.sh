#!/bin/bash

CONTROLLER=$1

shift

for port in $@ ; do
    curl -v -u admin:admin http://$CONTROLLER:8181/restconf/operations/alto-bwmonitor:bwmonitor-subscribe -H 'Content-type: application/json' -d '{"input":{"port-id":['$port']}}'
done

