#!/bin/bash

mkdir -p downloads

for site in `seq 1 5` ; do
    port=$(($site + 8181))
    curl -u admin:admin http://192.168.1.21:$port/restconf/operational/network-topology:network-topology | python -m json.tool > downloads/topology-domain$site.json
done
