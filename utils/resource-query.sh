#!/bin/bash

id=${1:-1}
port=$(($id+9000))

curl -v http://127.0.0.1:$port/experimental/v1/unicorn/resource-query -H 'Content-type: application/json' -d @query.json
