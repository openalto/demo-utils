#!/bin/bash

./subscribe-all.sh
./config-path-all.sh
./set-bandwidth-all.sh
./add-h2h-intent 10.0.1.101 10.0.1.201 localhost 8182
./add-h2h-intent 10.0.1.102 10.0.1.202 localhost 8182
