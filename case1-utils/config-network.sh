#!/bin/sh

for site in `seq 1 5` ; do
    pipework br0 unicorn$site 192.168.1.6$site/24@192.168.1.1 ;
done
