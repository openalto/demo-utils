#!/bin/bash

id=${1:-1}
port=$(($id+9000))

curl -v http://127.0.0.1:$port/experimental/v1/unicorn/on-demand-deploy -H 'Content-type: application/json' -d @demand.json
