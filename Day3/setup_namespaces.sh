#!/bin/bash

# Variables
BRIDGE_NAME="v-net-0"
SUBNET="192.168.15"
NAMESPACE_COUNT=3  # Number of namespaces to create

# Create the bridge
echo "Creating bridge: $BRIDGE_NAME"
ip link add $BRIDGE_NAME type bridge
ip link set dev $BRIDGE_NAME up

# Create namespaces and connect to the bridge
for i in $(seq 1 $NAMESPACE_COUNT); do
    NAMESPACE="ns-$i"
    VETH_NS="veth-$i"
    VETH_BR="veth-$i-br"
    IP="$SUBNET.$i"

    echo "Creating namespace: $NAMESPACE"
    ip netns add $NAMESPACE

    echo "Creating veth pair: $VETH_NS <-> $VETH_BR"
    ip link add $VETH_NS type veth peer name $VETH_BR

    echo "Assigning $VETH_NS to namespace: $NAMESPACE"
    ip link set $VETH_NS netns $NAMESPACE

    echo "Attaching $VETH_BR to bridge: $BRIDGE_NAME"
    ip link set $VETH_BR master $BRIDGE_NAME
    ip link set $VETH_BR up

    echo "Configuring IP $IP for namespace: $NAMESPACE"
    ip netns exec $NAMESPACE ip addr add $IP/24 dev $VETH_NS
    ip netns exec $NAMESPACE ip link set $VETH_NS up

    echo "Namespace $NAMESPACE setup complete"
done

# Verify setup
echo "Setup complete. Verifying..."
ip link show $BRIDGE_NAME
for i in $(seq 1 $NAMESPACE_COUNT); do
    ip netns exec ns-$i ip addr show
done
