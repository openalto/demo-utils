#!/bin/bash

mkdir -p downloads

site=${1:-1}
echo $site
port=$(($site + 8181))
curl -u admin:admin http://192.168.1.50:$port/restconf/operational/network-topology:network-topology | python -m json.tool > downloads/topology-domain$site.json
