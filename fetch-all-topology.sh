#!/bin/bash

mkdir -p downloads

for site in `seq 1 5` ; do
    curl -u admin:admin http://192.168.1.6$site/restconf/operational/network-topology:network-topology | python -m json.tool > downloads/topology-domain$site.json
done
