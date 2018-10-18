<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<flow xmlns="urn:opendaylight:flow:inventory">
    <id>{{ flow.id }}</id>
    <flow-name>{{ flow.name }}</flow-name>
    <table_id>{{ flow.table.id }}</table_id>

    <hard-timeout>{{ flow.hard_timeout }}</hard-timeout>
    <idle-timeout>{{ flow.idle_timeout }}</idle-timeout>

    <cookie>{{ flow.cookie }}</cookie>
    <priority>{{ flow.priority }}</priority>

    <match>
        <ethernet-match>
            <ethernet-type>
                <type>2048</type>
            </ethernet-type>
        </ethernet-match>
        <in-port>1</in-port>
    </match>

    <instructions>
        <instruction>
            <order>0</order>
            <apply-actions>
                <action>
                    <order>0</order>
                    <drop-action/>
                </action>
            </apply-actions>
        </instruction>
    </instructions>

</flow>
