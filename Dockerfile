from debian:stable-slim
LABEL maintainer="dro@arrakis.it"

# Install build dependencies
RUN apt-get update -y
RUN apt-get install -y python3 python3-pip build-essential pkg-config libffi-dev \
    libgmp-dev libssl-dev libtinfo-dev systemd libsystemd-dev libsodium-dev zlib1g-dev \
    npm yarn make g++ tmux git jq wget libncursesw5 gnupg libtool autoconf


# Install cabal
RUN wget https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz \
    && tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz \
    && rm cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz cabal.sig \
    && mv cabal /usr/bin/ \
    && cabal update

# Install GHC
RUN wget https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-x86_64-deb9-linux.tar.xz \
    && tar -xf ghc-8.6.5-x86_64-deb9-linux.tar.xz \
    && rm ghc-8.6.5-x86_64-deb9-linux.tar.xz \
    && cd ghc-8.6.5 \
    && ./configure \
    && make install && cd ..

# Install libsodium
RUN git clone https://github.com/input-output-hk/libsodium \
    && cd libsodium \
    && git checkout 66f017f1 \
    && ./autogen.sh && ./configure && make && make install
RUN export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

# Install cardano-node
ARG CARDANO_BRANCH
RUN echo "Building $CARDANO_BRANCH..." \
    && echo $CARDANO_BRANCH > /CARDANO_BRANCH
RUN mkdir -p /cardano-node/
RUN git clone https://github.com/input-output-hk/cardano-node.git \
    && cd cardano-node \
    && git fetch --all --tags \
    && git checkout $CARDANO_BRANCH
WORKDIR /cardano-node/
#RUN echo -e "package cardano-crypto-praos\n  flags: -external-libsodium-vrf" > cabal.project.local
#RUN cabal build all
RUN cabal install cardano-node cardano-cli

# Install tools
RUN apt-get install -y vim procps dnsutils bc curl nano cron

# Expose ports
## cardano-node, EKG, Prometheus
EXPOSE 3000 12788 12798

# ENV variables
ENV NODE_PORT="3000" \
    NODE_NAME="node1" \
    NODE_TOPOLOGY="" \
    NODE_RELAY="False" \
    CARDANO_NETWORK="main" \
    EKG_PORT="12788" \
    PROMETHEUS_HOST="127.0.0.1" \
    PROMETHEUS_PORT="12798" \
    RESOLVE_HOSTNAMES="False" \
    REPLACE_EXISTING_CONFIG="False" \
    CREATE_STAKEPOOL="False" \
    POOL_PLEDGE="100000000000" \
    POOL_COST="10000000000" \
    POOL_MARGIN="0.05" \
    METADATA_URL="" \
    PUBLIC_RELAY_IP="TOPOLOGY" \
    WAIT_FOR_SYNC="True" \
    AUTO_TOPOLOGY="True" \
    PATH="/root/.cabal/bin/:/scripts/:/cardano-node/scripts/:${PATH}"

# Add config
ADD cfg-templates/ /cfg-templates/
RUN mkdir -p /config/
VOLUME /config/

# Add scripts
RUN echo "source /scripts/init_node_vars" >> /root/.bashrc
ADD scripts/ /scripts/
RUN chmod -R +x /scripts/

ENTRYPOINT ["/scripts/start-cardano-node"]
