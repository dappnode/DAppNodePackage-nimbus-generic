#!/bin/sh

SUPPORTED_NETWORKS="gnosis holesky mainnet"
MEVBOOST_FLAG_KEY="--payload-builder=true"
SKIP_MEVBOOST_URL="true"
CLIENT="nimbus"

# shellcheck disable=SC1091
. /etc/profile

VALID_GRAFFITI=$(get_valid_graffiti "${GRAFFITI}")
VALID_FEE_RECIPIENT=$(get_valid_fee_recipient "${FEE_RECIPIENT_ADDRESS}")
SIGNER_API_URL=$(get_signer_api_url "${NETWORK}" "${SUPPORTED_NETWORKS}")
BEACON_API_URL=$(get_beacon_api_url "${NETWORK}" "${SUPPORTED_NETWORKS}" "${CLIENT}")
MEVBOOST_FLAG=$(get_mevboost_flag "${NETWORK}" "${MEVBOOST_FLAG_KEY}" "${SKIP_MEVBOOST_URL}")

echo "[INFO - entrypoint] Running validator service"

FLAGS="--log-level=$LOG_TYPE \
    --data-dir=$DATA_DIR \
    --doppelganger-detection=$ENABLE_DOPPELGANGER \
    --non-interactive \
    --web3-signer-url=$SIGNER_API_URL \
    --suggested-fee-recipient=$VALID_FEE_RECIPIENT \
    --keymanager=true \
    --keymanager-port=3500 \
    --keymanager-address=0.0.0.0 \
    --keymanager-allow-origin=* \
    --keymanager-token-file=$VALIDATOR_API_TOKEN_PATH \
    --metrics=true \
    --metrics-address=0.0.0.0 \
    --metrics-port=8008 \
    --graffiti=$VALID_GRAFFITI \
    --beacon-node=$BEACON_API_URL $MEVBOOST_FLAG $EXTRA_OPTS"

# shellcheck disable=SC2086
exec ${NIMBUS_BIN} $FLAGS
