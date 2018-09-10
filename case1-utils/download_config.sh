#!/bin/sh

for config_folder in config_1 config_2 config_3 config_4 config_5; do
    cd $config_folder
    wget https://raw.githubusercontent.com/openalto/demo-utils/master/docker/unicorn-server/config/mock.json
    wget https://raw.githubusercontent.com/openalto/demo-utils/master/docker/unicorn-server/config/orchestrators.json
    wget https://raw.githubusercontent.com/openalto/demo-utils/master/docker/unicorn-server/config/server.json
    wget https://raw.githubusercontent.com/openalto/demo-utils/master/docker/unicorn-server/config/web.xml
    cd ..
done
