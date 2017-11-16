#!/bin/bash

port=$(($1+8181))
BASEDIR=$2

for i in `seq 1 $3` ; do
    echo ""
    echo ""
    echo $BASEDIR/$i
    curl -v -u admin:admin -X PUT http://127.0.0.1:$port/restconf/config/alto-pathmanager:path-manager/path/$i -H 'Content-type: application/json' -d @$BASEDIR/path-manager-$i.json
done
