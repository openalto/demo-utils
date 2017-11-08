#!/bin/bash

CONTROLLER=${1:-localhost}

./check-flow.sh --filter '#UF' $CONTROLLER | ./remove-flow.sh $CONTROLLER
./check-flow.sh --filter 'L2switch' $CONTROLLER | ./remove-flow.sh $CONTROLLER

curl -v -u admin:admin -X PUT -H 'Content-Type: application/json' http://$CONTROLLER:8181/restconf/config/arp-handler-config:arp-handler-config -d '{"arp-handler-config":{"is-proactive-flood-mode":false}}'
