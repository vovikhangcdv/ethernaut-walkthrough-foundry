# Coin Flip

- Bug Class: `Randomness`

> Use of global variables like block hash, block number, block timestamp and other fields is insecure, miner and attacker can control it. - DeFiVulnLab

On the Sepolia network, where the block time is approximately 15 seconds, we should wait at least 15 seconds between transactions. In this scenario, we also need to perform the transaction 10 times.

To exploit the Randomness bug and achieve the desired outcome, execute the following script:

```bash
for i in {1..10}; do forge script script/level03.sol:Level03 -vvv --broadcast --skip-simulation && sleep 15s; done
```