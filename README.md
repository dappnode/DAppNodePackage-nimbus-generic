# Nimbus Dappnode package

**Nimbus ETH2.0 Beacon chain + validator**

From this repository, the Dappnode Nimbus package can be generated for 3 networks: the Hoodi Testnet, Ethereum Mainnet and Gnosis Chain.

## Gnosis support

The generic Nimbus package already supports **Gnosis** and already uses the split-client layout.

Default images for generic variants:
- `beacon-chain` → `statusim/nimbus-eth2`
- `validator` → `statusim/nimbus-validator-client`

For the **Gnosis** variant specifically, the package should use the Gnosis-maintained images:
- `beacon-chain` → `ghcr.io/gnosischain/gnosis-nimbus-eth2`
- `validator` → `ghcr.io/gnosischain/gnosis-nimbus-validator-client`

Gnosis images publish plain version tags, while the default Status images publish `multiarch-` prefixed tags. The Dockerfiles keep the default `statusim/*:multiarch-${UPSTREAM_VERSION}` behavior, and the Gnosis variant overrides both the image repository and image tag explicitly.

For Gnosis users, this generic package should be treated as the canonical multiclient package path instead of maintaining a separate single-service packaging model.

Nimbus is a client implementation for both the consensus layer (eth2) and execution layer (eth1) that strives to be as lightweight as possible in terms of resources used. This allows it to perform well on embedded systems, resource-restricted devices (including Raspberry Pis and mobile devices).

However, resource-restricted hardware is not the only thing Nimbus is good for. Its low resource consumption makes it easy to run Nimbus together with other workloads on your server (this is especially valuable for stakers looking to lower the cost of their server instances).

![avatar](avatar.png)
