sudo ovs-ofctl -O OpenFlow13 add-flow s1 ip,nw_dst=10.0.1.101,priority=1000,actions=output:1
sudo ovs-ofctl -O OpenFlow13 add-flow s1 ip,nw_dst=10.0.1.102,priority=1000,actions=output:2
sudo ovs-ofctl -O OpenFlow13 add-flow s1 ip,nw_src=10.0.1.101,priority=1000,actions=output:3
sudo ovs-ofctl -O OpenFlow13 add-flow s1 ip,nw_src=10.0.1.102,priority=1000,actions=output:3

sudo ovs-ofctl -O OpenFlow13 add-flow s4 ip,nw_dst=10.0.2.201,priority=1000,actions=output:1
sudo ovs-ofctl -O OpenFlow13 add-flow s4 ip,nw_dst=10.0.1.101,priority=1000,actions=output:2
sudo ovs-ofctl -O OpenFlow13 add-flow s4 ip,nw_dst=10.0.1.102,priority=1000,actions=output:2
sudo ovs-ofctl -O OpenFlow13 add-flow s4 ip,nw_dst=10.0.3.202,priority=1000,actions=output:3

sudo ovs-ofctl -O OpenFlow13 add-flow s6 ip,nw_dst=10.0.3.202,priority=1000,actions=output:1
sudo ovs-ofctl -O OpenFlow13 add-flow s6 ip,nw_src=10.0.3.202,priority=1000,actions=output:2

sudo ovs-ofctl -O OpenFlow13 add-flow s7 ip,nw_src=10.0.3.202,priority=1000,actions=output:1
sudo ovs-ofctl -O OpenFlow13 add-flow s7 ip,nw_dst=10.0.3.202,priority=1000,actions=output:2

sudo ovs-ofctl -O OpenFlow13 add-flow s8 ip,nw_src=10.0.3.202,priority=1000,actions=output:1
sudo ovs-ofctl -O OpenFlow13 add-flow s8 ip,nw_dst=10.0.3.202,priority=1000,actions=output:2