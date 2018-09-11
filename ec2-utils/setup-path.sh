#!/bin/bash

id=${1:-1}
#port=$((8181+$id))
address_array=('172.31.5.84:8181' '172.31.5.236:8181' '172.31.12.73:8181')
address=${address_array[$id]}
port=8181
config_folder=config_$id
path_id=${2:-1}
path_json=path-$path_id.json

PYUNICORN_PATH=$HOME

data=`cat $(pwd)/$config_folder/$path_json`
echo $data

$PYUNICORN_PATH/pyunicorn -e http://$address --data "$data" setup_path
