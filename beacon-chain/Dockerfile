ARG UPSTREAM_VERSION

FROM statusim/nimbus-eth2:multiarch-${UPSTREAM_VERSION}

ARG NETWORK
ARG STAKER_SCRIPTS_VERSION
ARG DATA_DIR
ARG P2P_PORT

ENV JWT_FILE_PATH=/jwtsecret.hex \
    VALIDATOR_PORT=3500 \
    DATA_DIR=${DATA_DIR} \
    P2P_PORT=${P2P_PORT} \
    NIMBUS_BIN="/home/user/nimbus_beacon_node" \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ADD ${STAKER_SCRIPTS_URL}/consensus_tools.sh /etc/profile.d/

USER root

RUN apt-get update && apt-get --yes install curl && apt-get clean && \
    chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/consensus_tools.sh

# This env changes the variant
# Placed at the end to regenerate the least amount of layers
ENV NETWORK=${NETWORK}

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]