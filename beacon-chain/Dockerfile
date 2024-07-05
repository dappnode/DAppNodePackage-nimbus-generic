ARG UPSTREAM_VERSION

FROM statusim/nimbus-eth2:multiarch-${UPSTREAM_VERSION}

ARG NETWORK
ARG P2P_PORT
ARG STAKER_SCRIPTS_VERSION

USER root

RUN apt-get update && apt-get install -y curl && apt-get clean

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY jwtsecret.hex /jwtsecret

ENV JWT_SECRET_FILE=/jwtsecret \
    NETWORK=${NETWORK} \
    VALIDATOR_PORT=3500 \
    P2P_PORT=${P2P_PORT} \
    NIMBUS_BIN="/home/user/nimbus_beacon_node" \
    DATA_DIR="/home/user/nimbus-eth2/build/data" \
    TOKEN_FILE="${DATA_DIR}/auth-token" \
    AUTH_TOKEN_PATH=${AUTH_TOKEN_PATH} \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

ADD ${STAKER_SCRIPTS_URL}/consensus_tools.sh /etc/profile.d/

RUN chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/consensus_tools.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]