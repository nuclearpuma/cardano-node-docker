#!/bin/bash

# Init config
if [ ! -f "/config/config.yml" ]; then
    cp /config.tmpl.yml /config/config.yml
    sed -i "s/\[SCRAPE_INTERVAL\]/${SCRAPE_INTERVAL}/g" /config/config.yml
    sed -i "s/\[NODE_PORT\]/${NODE_PORT}/g" /config/config.yml
    sed -i "s/\[NODE_HOST\]/${NODE_HOST}/g" /config/config.yml
fi

prometheus -config.file=/config/config.yml