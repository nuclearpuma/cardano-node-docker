#!/bin/bash

#
# This is an example on how to start a block-producing node on the pioneet network
#

docker run -it --rm \
    --name pioneer-producing \
    -p 3000:3000 \
    -p 12798:12798 \
    -e PUID=$(id -u) \
    -e PGID=$(id -u) \
    -e NODE_PORT="3000" \
    -e NODE_NAME="block-producing" \
    -e NODE_TOPOLOGY="<IP-address of relay1 node>:3000/1" \
    -e CARDANO_NETWORK="pioneer" \
    -e PROMETHEUS_PORT="12798" \
    -v $PWD/config/:/config/ \
    arrakis/cardano-node:1.13.0 --start --staking
