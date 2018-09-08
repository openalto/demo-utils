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
           {% if eth_type %}
             <ethernet-type>
               <type>{{ eth_type }}</type>
             </ethernet-type>
           {% endif %}

           {% if eth_source %}
           <ethernet-source>
               <address>{{ eth_source }}</address>
           </ethernet-source>
           {% endif %}

           {% if eth_destination %}
           <ethernet-destination>
               <address>{{ eth_destination }}</address>
           </ethernet-destination>
           {% endif %}
       </ethernet-match>

       {% if ipv4_source %}
       <ipv4-source>{{ ipv4_source }}</ipv4-source>
       {% endif %}

       {% if ipv4_destination %}
       <ipv4-destination>{{ ipv4_destination }}</ipv4-destination>
       {% endif %}

    </match>

    <instructions>
        <instruction>
            <order>0</order>
            <apply-actions>
                <action>
                    <order>0</order>
                    <output-action>
                        <output-node-connector>{{ connector_id }}</output-node-connector>
                    </output-action>
                </action>
            </apply-actions>
        </instruction>
    </instructions>

</flow>
