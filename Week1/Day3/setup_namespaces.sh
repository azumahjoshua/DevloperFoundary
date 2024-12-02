## Overview
- Network Namespace 1 (NetNS1): Represents one isolated network.
- Network Namespace 2 (NetNS2): Represents the other isolated network.
- Gateway: A virtual router (using a Linux bridge) to enable communication between the two namespaces.

## Steps to Set Up the Virtual Network
1. Create Network Namespaces
```bash
ip netns add netns1
ip netns add netns2
```
2. Show Network Interface
```bash
ip link
```
2. Create Virtual Ethernet Pairs
Each namespace will connect to the gateway through a virtual Ethernet (veth) pair.
```bash
ip link add veth1 type veth peer name veth2
# ip link add veth2 type veth peer name veth2-br
```
3. Assign Interfaces to Namespaces
Move one end of each veth pair into the corresponding namespace.
```bash
ip link set veth1 netns netns1
ip link set veth2 netns netns2
```
4. Set Up a Linux Bridge (Gateway)
```bash
ip link add name br0 type bridge
ip link set br0 up
```
Attach the other ends of the veth pairs (veth1-br and veth2-br) to the bridge.
```bash
ip link set veth1-br master br0
ip link set veth2-br master br0
ip link set veth1-br up
ip link set veth2-br up
```
5. Configure IP Addresses
- In NetNS1:
```bash
ip netns exec netns1 ip addr add 192.168.1.2/24 dev veth1
ip netns exec netns1 ip link set veth1 up
ip netns exec netns1 ip route add default via 192.168.1.1
```
- In NetNS2:
```bash
ip netns exec netns2 ip addr add 192.168.2.2/24 dev veth2
ip netns exec netns2 ip link set veth2 up
ip netns exec netns2 ip route add default via 192.168.2.1
```
- On the Bridge (Gateway):
```bash
ip addr add 192.168.1.1/24 dev br0
ip addr add 192.168.2.1/24 dev br0
```
6. Enable IP Forwarding
```bash
sysctl -w net.ipv4.ip_forward=1
```
7. Add iptables Rules for NAT
To allow communication between the namespaces:
```bash
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o br0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o br0 -j MASQUERADE
```
## Test the Setup
Ping Between Namespaces
- From netns1 to netns2:
```bash
ip netns exec netns1 ping 192.168.2.2
```
- From netns2 to netns1:
```bash
ip netns exec netns2 ping 192.168.1.2
```
## Verify Connectivity

If the setup is correct, you should see successful ping responses.

Diagram Representation

[ NetNS1 (192.168.1.2) ] <--> [ veth1 ] <--> [ br0 (192.168.1.1/192.168.2.1) ] <--> [ veth2 ] <--> [ NetNS2 (192.168.2.2) ]

Clean Up

To tear down the setup, run:
```bash
ip netns del netns1
ip netns del netns2
ip link del br0
```