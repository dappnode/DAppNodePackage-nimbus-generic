#!/bin/sh

SUPPORTED_NETWORKS="gnosis holesky mainnet"
MEVBOOST_FLAG="--payload-builder=true"
SKIP_MEVBOOST_URL="true"
CLIENT="nimbus"

# shellcheck disable=SC1091
. /etc/profile

run_validator() {
    echo "[INFO - entrypoint] Running validator service"

    # shellcheck disable=SC2086
    exec ${NIMBUS_BIN} \
        --log-level="${LOG_TYPE}" \
        --doppelganger-detection="${ENABLE_DOPPELGANGER}" \
        --non-interactive=true \
        --web3-signer-url="${WEB3SIGNER_API_URL}" \
        --suggested-fee-recipient="${FEE_RECIPIENT}" \
        --keymanager=true \
        --keymanager-port=3500 \
        --keymanager-address=0.0.0.0 \
        --keymanager-allow-origin=* \
        --keymanager-token-file="${AUTH_TOKEN_PATH}" \
        --metrics=true \
        --metrics-address=0.0.0.0 \
        --metrics-port=8008 \
        --graffiti="${GRAFFITI}" \
        --beacon-node="${BEACON_API_URL}" ${EXTRA_OPTS}
}

format_graffiti
set_validator_config_by_network "${NETWORK}" "${SUPPORTED_NETWORKS}" "${CLIENT}"
set_mevboost_flag "${MEVBOOST_FLAG}" "${SKIP_MEVBOOST_URL}" # MEV-Boost: https://chainsafe.github.io/lodestar/usage/mev-integration/
run_validator
