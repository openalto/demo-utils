#!/bin/bash

id=${1:-1}
port=$(($id+8181))

curl -v -u admin:admin -X PUT http://127.0.0.1:$port/restconf/config/alto-pathmanager:path-manager/ -H 'Content-type: application/json' -d '{"path-manager": {"path": []}}'
