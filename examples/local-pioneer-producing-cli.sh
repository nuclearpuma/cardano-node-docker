#!/bin/bash

#
# This is an example on how to start cli for the block-producing node.
#

docker run -it --rm \
    --network=host \
    -e PUID=$(id -u) \
    -e PGID=$(id -u) \
    -e NODE_PORT="3000" \
    -e NODE_NAME="block-producing" \
    -e NODE_TOPOLOGY="127.0.0.1:3001/1" \
    -e NODE_RELAY="False" \
    -e CARDANO_NETWORK="pioneer" \
    -e EKG_PORT="12788" \
    -e PROMETHEUS_PORT="12798" \
    -e RESOLVE_HOSTNAMES="True" \
    -e REPLACE_EXISTING_CONFIG="False" \
    -e HOST_ADDR="127.0.0.1" \
    -e POOL_PLEDGE="100000000000" \
    -e POOL_COST="10000000000" \
    -e POOL_MARGIN="0.05" \
    -e CREATE_STAKEPOOL="True" \
    -v $PWD/config/local/:/config/ \
    arrakis/cardano-node:1.13.0 --cli