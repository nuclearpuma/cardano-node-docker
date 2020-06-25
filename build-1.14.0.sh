#!/bin/bash

docker build --no-cache --build-arg CARDANO_BRANCH=tags/1.14.0 -t arrakis/cardano-node:1.14.0 .
