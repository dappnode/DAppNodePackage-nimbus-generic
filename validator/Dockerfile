ARG UPSTREAM_VERSION

FROM statusim/nimbus-validator-client:multiarch-${UPSTREAM_VERSION}

ARG NETWORK
ARG STAKER_SCRIPTS_VERSION
ARG DATA_DIR

ENV DATA_DIR=${DATA_DIR} \
    VALIDATOR_API_TOKEN_PATH=/security/auth-token \
    NIMBUS_BIN="/home/user/nimbus_validator_client" \
    STAKER_SCRIPTS_URL=https://github.com/dappnode/staker-package-scripts/releases/download/${STAKER_SCRIPTS_VERSION}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY auth-token ${VALIDATOR_API_TOKEN_PATH}

ADD ${STAKER_SCRIPTS_URL}/consensus_tools.sh /etc/profile.d/

USER root

RUN apt-get update && apt-get --yes install curl && apt-get clean && \
    chmod +rx /usr/local/bin/entrypoint.sh /etc/profile.d/consensus_tools.sh

# This env changes the variant
# Placed at the end to regenerate the least amount of layers
ENV NETWORK=${NETWORK}

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]