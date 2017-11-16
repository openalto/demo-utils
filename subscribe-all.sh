#!/bin/sh

./subscribe-ports.sh 1 openflow:12:1
./subscribe-ports.sh 2 openflow:7:1
./subscribe-ports.sh 3 openflow:9:1 openflow:9:2 openflow:11:2
./subscribe-ports.sh 4 openflow:1:3 openflow:1:1
./subscribe-ports.sh 5 openflow:5:1
