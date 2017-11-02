#!/bin/bash

CONTROLLER=${1:-localhost}

while read line
do
    echo "Removing flows about $line"
    curl -v -u admin:admin -X POST -d "$(./generate-input.sh $line)" -H 'Content-Type: application/xml' http://$CONTROLLER:8181/restconf/operations/sal-flow:remove-flow
done < "${2:-/dev/stdin}"
