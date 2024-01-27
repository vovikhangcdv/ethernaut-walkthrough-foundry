# Vault

- Bug Class: `Private Data`

In this level, the vulnerability is related to `Private Data`. It's essential to understand that on the blockchain, there is no inherent privacy, and all data is transparent. Leveraging a load operation from Foundry allows us to read what is typically considered private information, such as passwords. This exploit enables the unlocking (solving) of the challenge by accessing supposedly confidential data.

One way to exploit this vulnerability is to use the Foundry framework to execute a load operation, allowing you to read the private password and unlock the vault.
