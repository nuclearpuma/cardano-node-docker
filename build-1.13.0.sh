#!/bin/bash

docker build --build-arg CARDANO_BRANCH=tags/1.13.0 -t arrakis/cardano-node:1.13.0 .
