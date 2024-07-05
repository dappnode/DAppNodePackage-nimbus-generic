#!/bin/sh

if [ -z "${NETWORK}" ]; then
    echo "NETWORK is not defined. Exiting."
    exit 1
fi

if [ "${NETWORK}" = "mainnet" ]; then
    BEACON_CHAIN_URL="http://beacon-chain.nimbus.dappnode:3500"
    VALIDATOR_URL="http://validator.nimbus.dappnode:3500"
else
    BEACON_CHAIN_URL="http://beacon-chain.nimbus-${NETWORK}.dappnode:3500"
    VALIDATOR_URL="http://validator.nimbus-${NETWORK}.dappnode:3500"
fi

# Replace variables in nginx.conf
sed -e "s|\${VALIDATOR_URL}|${VALIDATOR_URL}|g" -e "s|\${BEACON_CHAIN_URL}|${BEACON_CHAIN_URL}|g" /etc/nginx/nginx.conf.template >/etc/nginx/nginx.conf

# Start nginx
exec "$@"
