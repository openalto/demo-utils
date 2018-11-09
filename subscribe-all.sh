subscribe-port() {
    hostname=$1
    http_port=$2
    ports=$(curl -s -u admin:admin http://$hostname:$http_port/restconf/operational/opendaylight-inventory:nodes | jq -r '.nodes.node[]."node-connector"[].id|select(endswith("LOCAL")|not)')

    for port in $ports; do
        curl -v -u admin:admin http://$hostname:$http_port/restconf/operations/alto-bwmonitor:bwmonitor-subscribe -H 'Content-type: application/json' -d '{"input":{"port-id":["'$port'"]}}'
    done
}

subscribe-port unicorn1 8181
subscribe-port unicorn2 8181