ARG UPSTREAM_VERSION

FROM statusim/nimbus-validator-client:multiarch-${UPSTREAM_VERSION}

ARG NETWORK
ARG STAKER_SCRIPTS_VERSION
ARG AUTH_TOKEN_PATH=/security/auth-token

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY auth-token ${AUTH_TOKEN_PATH}

ENV NETWORK=${NETWORK} \
    AUTH_TOKEN_PATH=${AUTH_TOKEN_PATH} \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

ADD ${STAKER_SCRIPTS_URL}/consensus_tools.sh /etc/profile.d/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]