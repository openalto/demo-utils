function fetch_topology{
    hostname=$1
    http_port=$2
    curl -u admin:admin http://$hostname:$http_port/restconf/operational/network-topology:network-topology | jq . > $(hostname)_topo.json
}

fetch_topology unicorn1 8181
fetch_topology unicorn2 8181