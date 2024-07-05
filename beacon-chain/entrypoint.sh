#!/bin/sh

SUPPORTED_NETWORKS="gnosis holesky mainnet"
MEVBOOST_FLAGS="--payload-builder=true --payload-builder-url"

# shellcheck disable=SC1091 # Path is relative to the Dockerfile
. /etc/profile

handle_checkpoint() {
    # Run checkpoint sync script if provided
    if [ -n "${CHECKPOINT_SYNC_URL}" ]; then
        echo "[INFO - entrypoint] Running checkpoint sync script"

        ${NIMBUS_BIN} trustedNodeSync \
            --network="${NETWORK}" \
            --trusted-node-url="${CHECKPOINT_SYNC_URL}" \
            --backfill=false \
            --data-dir="${DATA_DIR}"
    else
        echo "[WARN - entrypoint] No checkpoint sync script provided. Syncing from genesis."
    fi
}

run_beacon() {
    echo "[INFO - entrypoint] Running beacon node service"

    # shellcheck disable=SC2086
    exec ${NIMBUS_BIN} \
        --network="${NETWORK}" \
        --data-dir="${DATA_DIR}" \
        --tcp-port="${P2P_PORT}" \
        --udp-port="${P2P_PORT}" \
        --log-level="${LOG_TYPE}" \
        --rest \
        --rest-port=3500 \
        --rest-address=0.0.0.0 \
        --metrics \
        --metrics-address=0.0.0.0 \
        --metrics-port=8008 \
        --jwt-secret=/jwtsecret \
        --web3-url="${ENGINE_API_URL}" \
        --suggested-fee-recipient="${FEE_RECIPIENT}" ${EXTRA_OPTS}
}

format_graffiti
set_beacon_config_by_network "${NETWORK}" "${SUPPORTED_NETWORKS}"
handle_checkpoint
set_mevboost_flag "${MEVBOOST_FLAGS}" # MEV-Boost: https://chainsafe.github.io/lodestar/usage/mev-integration/
run_beacon
