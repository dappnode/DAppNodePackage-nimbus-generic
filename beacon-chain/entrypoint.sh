#!/bin/sh

MEVBOOST_FLAG_KEYS="--payload-builder=true --payload-builder-url"

# shellcheck disable=SC1091 # Path is relative to the Dockerfile
. /etc/profile

ENGINE_URL="http://execution.${NETWORK}.staker.dappnode:8551"
VALID_FEE_RECIPIENT=$(get_valid_fee_recipient "${FEE_RECIPIENT}")
MEVBOOST_FLAG=$(get_mevboost_flag "${NETWORK}" "${MEVBOOST_FLAG_KEYS}")

JWT_SECRET=$(get_jwt_secret_by_network "${NETWORK}")
echo "${JWT_SECRET}" >"${JWT_FILE_PATH}"

if [ -n "$(ls -A "${DATA_DIR}/db" 2>/dev/null)" ]; then
    echo "[INFO - entrypoint] Data directory has already been initialized, skipping checkpoint sync."

elif [ -n "${CHECKPOINT_SYNC_URL}" ]; then
    echo "[INFO - entrypoint] Running checkpoint sync script"

    ${NIMBUS_BIN} trustedNodeSync \
        --network="${NETWORK}" \
        --trusted-node-url="${CHECKPOINT_SYNC_URL}" \
        --backfill=false \
        --data-dir="${DATA_DIR}"

else
    echo "[WARN - entrypoint] No checkpoint sync script provided. Syncing from genesis."
fi

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
    --web3-url="${ENGINE_URL}" \
    --suggested-fee-recipient="${VALID_FEE_RECIPIENT}" ${MEVBOOST_FLAG} ${EXTRA_OPTS}
