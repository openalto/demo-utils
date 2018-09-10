#!/bin/bash

CONTROLLER=localhost
PORT=$(($1+8181))

echo $PORT

./check-flow.sh --filter '#UF' $1 | ./remove-flow.sh $1
./check-flow.sh --filter 'L2switch' $1 | ./remove-flow.sh $1

curl -v -u admin:admin -X PUT -H 'Content-Type: application/json' http://$CONTROLLER:$PORT/restconf/config/arp-handler-config:arp-handler-config -d '{"arp-handler-config":{"is-proactive-flood-mode":false}}'
