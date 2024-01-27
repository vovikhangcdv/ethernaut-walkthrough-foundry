# Fallout

- Bug Class: `Logic`

To exploit the logic bug in this level, follow these steps:

1. Contribute less than 0.001 ether to the contract.
2. Send exactly 0.001 ether to the contract to trigger the fallback function and set the owner to `msg.sender`.
3. Withdraw the contract balance.

