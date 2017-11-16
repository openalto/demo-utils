#!/bin/bash

CONTROLLER=$1
BASEDIR=$2

for i in `seq 1 $3` ; do
    curl -v -u admin:admin -X PUT http://$1:8181/restconf/config/alto-pathmanager:path-manager/path/1 -H 'Content-type: application/json' -d "$(cat path-manager-$i.json)"
done
