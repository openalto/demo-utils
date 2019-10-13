#!/bin/bash

function get_all_ports {
    hostname=$1
    http_port=$2
    ports=$(curl -s -u admin:admin http://$hostname:$http_port/restconf/operational/opendaylight-inventory:nodes | jq -r '.nodes.node[]."node-connector"[].id|select(endswith("LOCAL")|not)')
    echo $ports
}

function subscribe_port {
    hostname=$1
    http_port=$2

    ports=$(get_all_ports $hostname $http_port)

    for port in $ports; do
        curl -v -u admin:admin http://$hostname:$http_port/restconf/operations/alto-bwmonitor:bwmonitor-subscribe -H 'Content-type: application/json' -d '{"input":{"port-id":["'$port'"]}}'
    done
}

function config_capacity {
    IP=$1
    HTTP_PORT=$2
    CAPACITY=$3

    shift

    for port in $@ ; do
        curl -v -X PUT -u admin:admin http://$IP:$HTTP_PORT/restconf/config/alto-bwmonitor:config-capacity/capacity/$port -H 'Content-type: application/json' -d '{"capacity": {"port-id":"'$port'", "capacity": '$CAPACITY'}}'
    done
}
