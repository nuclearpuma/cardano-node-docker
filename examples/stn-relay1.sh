#!/bin/bash

#
# This is an example on how to start a relay node on the shelley test network
#

docker run -it --rm \
    --name stn-relay1 \
    -p 3000:3000 \
    -p 12798:12798 \
    -e PUID=$(id -u) \
    -e PGID=$(id -u) \
    -e NODE_PORT="3000" \
    -e NODE_NAME="relay1" \
    -e NODE_TOPOLOGY="<IP-address of block-producing node>:3000/1" \
    -e NODE_RELAY="True" \
    -e CARDANO_NETWORK="shelley_test" \
    -e PROMETHEUS_PORT="12798" \
    -v $PWD/config/:/config/ \
    arrakis/cardano-node:1.14.1 --start
