#!/bin/bash

#
# This is an example on how to start a relay node on the pioneet network
#

docker run -it --rm \
    --network=host \
    --name local-stn-relay1 \
    -e PUID=$(id -u) \
    -e PGID=$(id -u) \
    -e NODE_PORT="3001" \
    -e NODE_NAME="local-relay1" \
    -e NODE_RELAY="True" \
    -e NODE_TOPOLOGY="127.0.0.1:3000/1" \
    -e CARDANO_NETWORK="shelley_test" \
    -e EKG_PORT="12789" \
    -e PROMETHEUS_PORT="12799" \
    -e HOST_ADDR="0.0.0.0" \
    -v $PWD/config/local/:/config/ \
    arrakis/cardano-node:latest --start