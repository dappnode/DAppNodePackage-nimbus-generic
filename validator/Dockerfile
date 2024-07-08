ARG UPSTREAM_VERSION

FROM statusim/nimbus-validator-client:multiarch-${UPSTREAM_VERSION}

ARG NETWORK
ARG STAKER_SCRIPTS_VERSION
ARG VALIDATOR_API_TOKEN_PATH=/security/auth-token

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY auth-token ${VALIDATOR_API_TOKEN_PATH}

ENV NETWORK=${NETWORK} \
    VALIDATOR_API_TOKEN_PATH=${VALIDATOR_API_TOKEN_PATH} \
    NIMBUS_BIN="/home/user/nimbus_validator_client" \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

ADD ${STAKER_SCRIPTS_URL}/consensus_tools.sh /etc/profile.d/

RUN chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/consensus_tools.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]