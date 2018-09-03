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

Application request:

``` http
POST /resource-query
Host: unicorn.example.com
Accept: application/json
Content-Type: application/json

{
  query-desc: [
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

## Install Dependencies

``` bash
pip install -r requirements.txt
```

