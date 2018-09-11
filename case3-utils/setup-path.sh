#!/bin/bash

id=${1:-1}
port=$((8181+$id))
config_folder=config_$id
path_id=${2:-1}
path_json=path-$path_id.json

PYUNICORN_PATH=/usr/local/bin

data=`cat $(pwd)/$config_folder/$path_json`
echo $data

$PYUNICORN_PATH/pyunicorn -e http://127.0.0.1:$port --data "$data" setup_path
