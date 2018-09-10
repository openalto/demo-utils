# Unicorn Demo on AFM 2018

This demo will reuse the components provided by
[alto-experimental](https://github.com/openalto/alto-experimental),
[alto-domain-agent](https://github.com/openalto/alto-domain-agent) and
[alto-orchestrator](https://github.com/openalto/alto-orchestrator) to
demonstrate the main features of the Unicorn system.

## Environment Setup

This demo uses [mininet](https://github.com/mininet/mininet) and
[xdom-mn](https://github.com/openalto/xdom-mn) to simulate the single-domain
and multi-domain cases individually. The demo topology is provided at the
directory
[topology](https://github.com/openalto/demo-utils/tree/afm2018/topology).

The basic single-domain topology for this demo:

```
s1 --- sw1     sw6     sw3 --- d1
          \   /   \   /
           sw5     sw8
          /   \   /   \
s2 --- sw2     sw7     sw4 --- d2

       Each link: 100 Mbps
```

The default static routes:

```
s1 -> sw1 -> sw5 -> sw6 -> sw8 -> sw3 -> d1
s2 -> sw2 -> sw5 -> sw6 -> sw8 -> sw4 -> d2
```

The basic resource reservation request from the application side:

```
s1 -> d1
s2 -> d2
```

The major benefit of SFP is for the multi-domain scenario. We will demonstrate
the key features by using the following basic multi-domain topology:

```
+------------------------+   +-------------+   +----------------+
| s1 --- sw1             |   |     sw2     |   |     sw2 --- d1 |
|           \            |   |    /   \    |   |    /  |        |
|            sw3 --- sw4 ===== sw1     sw4 ===== sw1   |        |
|           /            |   |    \   /    |   |    \  |        |
| s2 --- sw2             |   |     sw3     |   |     sw3 --- d2 |
+------------------------+   +-------------+   +----------------+
         Site A                  Site B              Site C
```

## Demo Plan

We demonstrate the efficiency and efficacy of SFP (SDN Federation Protocol) in
the following 4 cases:

**Case 1**. Assume a scenario of two coalition partners (US Army and UK Army).
Suppose that US army sends two large sensing datasets through fixed routes in
the network infrastructure of UK Army; one from server 1 to server 2 and
another from server 3 to server 4. US Army submits a resource discovery request
to UK army by specifying two flows (server 1 to server 2 and server 3 to server
4). Once receiving the request, UK Army examines the fixed routes for both
flows, and returns the bandwidth sharing information of two flows to US Army in
the form of a set of linear inequalities. Then, US Army uses this set of linear
inequalities to determine the optimal and feasible bandwidth allocation to
transfer both datasets.

**Case 2**. Extension of Case 1 with: (1) the routes in UK Army's network
infrastructure for both dataset transfers are not fixed, i.e., on-demand
routing; and (2) US Army wants each dataset to pass a deep packet inspector
(DPI) middlebox before arriving at the destinations while guaranteeing >20Mbps
bandwidth for the transfer from server 1 to server 2.

**Case 3**. Extension of Case 1 with: (1) there are three coalition partners, i.e.,
US Army Division 1, US Army Division 2, and UK Army, and (2) US Army Division 1
wants to transfer both datasets using network infrastructures of all three
coalition partners, and the inter-partner route is known to be US Army Division
1 -> US Army Division 2 -> UK Army. In this case, US Army Division 1 needs to
collect bandwidth sharing information from US Army Division 2 and UK Army.

**Case 4**. Extension of Case 3 with: (1) the inter-partner route is unknown. In
this case, US Army Division 1 needs to first collect the inter-partner route
information from US Army Division 2 and UK Army. Then US Army Division queries
the bandwidth sharing information of US Army Division 2 and UK Army based on
the collected inter-partner route information.

### Case 1: Single Domain, Fixed Route

``` bash
# TODO: Show the cmd to setup the orchestrator and the unicorn server

```

The route is fixed for the given flow.

When demonstrate this case, the network operator should installed the route for
the give flow before any reqeust.

``` bash
# TODO: Show the cmd to install the host-to-host intent proactively

```

Then the user submits a task (involving a set of flows) to our demo
orchestrator.

``` bash
# TODO: Show the cmd to send a task

```

The orchestrator then will query the single-domain resource discovery by
sending a HTTP request.

Application request:

``` http
POST <base-uri>/resource-query
Host: unicorn.example.com
Accept: application/json
Content-Type: application/json

{
  "query-desc": [
    {
      "flow": {
        "flow-id": 0,
        "src-ip": "10.0.1.101",
        "dst-ip": "10.0.1.201",
        "protocol": "tcp"
      },
      "ingress-point": ""
    },
    {
      "flow": {
        "flow-id": 1,
        "src-ip": "10.0.1.102",
        "dst-ip": "10.0.1.202",
        "protocol": "tcp"
      },
      "ingress-point": ""
    }
  ]
}
```

``` bash
# TODO: Show the immediate request/response between the orchestrator
#       and the unicorn server

```

Once receiving the resource constraints, the orchestrator will compute an
optimal resource reservation and perform it.

``` bash
# TODO: show the optimal problem the orchestrator will compute 

# TODO: show the immediate cmd the orchestrator will invoke to
#       perform the resource reservation

# TODO: show the immediate cmd the orchestrator will invoke to
#       start the data transfer

```

### Case 2: Single Domain, On-Demand Route

Modify the `web.xml` file to config the unicorn server with the on-demand route
support. You can check your topology view in the controller to find the node
id.

``` xml
  ...

  <!-- The following config may be used by the on-demand route -->
  <context-param>
    <description>The node id of the switch attached to the DPI</description>
    <param-name>adapter.dpi</param-name>
    <param-value>openflow:6</param-value> <!-- Assume sw6 attached to the DPI node -->
  </context-param>

  ...
```

After that, the client can send a request for the on-demand path compute and
setup. The unicorn domain agent will compute available path satisfying the
demand submitted by the client.

Currently, the demand includes `min-bw` (guarantee the available bandwidth >= a
given value) and `pass-to-dpi` (a boolean value to specify whether the path
needs to pass a DPI attached node).

We give an example of the data transfer task with the waypoint requirement.

``` http
POST <base-uri>/on-demand-deploy HTTP/1.1
Host: alto.example.com
Content-Type: application/json

[
    {
        "src": "10.0.1.101",
        "dst": "10.0.1.201",
        "min-bw": 20000,
        "pass-to-dpi": true
    },
    {
        "src": "10.0.1.102",
        "dst": "10.0.1.202",
        "min-bw": 20000,
        "pass-to-dpi": true
    }
]
```

The following steps similar to Case 1. You can send the same `/resource-query`
request to the domain agent.

### Case 3: Multi-Domain, Fixed Inter-Domain Routing

TBD.

### Case 4: Multi-Domain, On-Demand Inter-Domain Routing

TBD.

## Install Dependencies

``` bash
make prepare
```

