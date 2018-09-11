#!/bin/bash

IP=${1:-local}
PORT=${2:-8181}

curl -v -u admin:admin -X PUT http://$IP:$PORT/restconf/config/alto-pathmanager:path-manager/ -H 'Content-type: application/json' -d '{"path-manager": {"path": []}}'
