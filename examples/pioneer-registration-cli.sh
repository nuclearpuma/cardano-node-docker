#!/bin/bash

#
# This is an example on how to initialize and register your stakepool on the pioneet network
#

docker run -it --rm \
    --name pioneer-registration \
    -p 3000:3000 \
    -p 12798:12798 \
    -e PUID=$(id -u) \
    -e PGID=$(id -u) \
    -e NODE_PORT="3000" \
    -e NODE_NAME="registration" \
    -e NODE_TOPOLOGY="<IP-address of relay1 node>:3000/1" \
    -e CARDANO_NETWORK="pioneer" \
    -e PROMETHEUS_PORT="12798" \
    -e CREATE_STAKEPOOL="True" \
    -e POOL_PLEDGE="100000000000" \
    -e POOL_COST="10000000000" \
    -e POOL_MARGIN="0.05" \
    -v $PWD/config/:/config/ \
    arrakis/cardano-node:1.13.0 --cli
