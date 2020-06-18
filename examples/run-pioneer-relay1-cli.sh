#!/bin/bash

#
# This is an example on how to start cli for a node.
#

# Start relay node
docker run -it --rm \
    --network=host \
    -e PUID=$(id -u) \
    -e PGID=$(id -u) \
    -e NODE_PORT="3001" \
    -e NODE_NAME="relay1" \
    -e NODE_RELAY="True" \
    -e NODE_TOPOLOGY="127.0.0.1:3000/1" \
    -e CARDANO_NETWORK="pioneer" \
    -e EKG_PORT="12789" \
    -e PROMETHEUS_PORT="12799" \
    -e RESOLVE_HOSTNAMES="True" \
    -e REPLACE_EXISTING_CONFIG="False" \
    -e HOST_ADDR="127.0.0.1" \
    -v $PWD/active_config/pioneer/relay1:/config/ \
    arrakis/cardano-node:1.13.0 --cli
