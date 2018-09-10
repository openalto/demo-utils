#!/bin/bash

FILTER=false
CONTROLLER=localhost
#PORT=$(($3+8181))
PORT=8182

while true; do
    case "$1" in
        --filter)
            FILTER=true
            FILTER_HEAD=$2
            shift 2
            ;;
        *)
            shift
            break
            ;;
    esac
done

if [[ "$FILTER" == "false" ]]; then
    curl -u admin:admin -H 'Content-Type: application/json' http://$CONTROLLER:$PORT/restconf/operational/opendaylight-inventory:nodes | jq '.nodes | .node | .[] | ."flow-node-inventory:table" | .[] | .flow' | ack '"id"'
else
    if [[ -n $FILTER_HEAD ]]; then
        curl -u admin:admin -H 'Content-Type: application/json' http://$CONTROLLER:$PORT/restconf/operational/opendaylight-inventory:nodes | ./uf_filter.py -H $FILTER_HEAD
    else
        curl -u admin:admin -H 'Content-Type: application/json' http://$CONTROLLER:$PORT/restconf/operational/opendaylight-inventory:nodes | ./uf_filter.py
    fi
fi
