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

## Install Dependencies

``` bash
pip install -r requirements.txt
```

