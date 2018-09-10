#!/bin/bash

echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<input xmlns="urn:opendaylight:flow:service">
  <barrier>false</barrier>
  <node xmlns:inv="urn:opendaylight:inventory">/inv:nodes/inv:node[inv:id="'$1'"]</node>
  <cookie>'$3'</cookie>
  <table_id>'$2'</table_id>
</input>'
