# Force

- Bug Class: `Selfdestruct to force ether to be sent to a contract`

In this level, the vulnerability involves utilizing a `selfdestruct` operation to compel the transfer of ether to a contract. Specifically, the goal is to disrupt the logic of the target contract that checks its balance.

Exploiting this bug requires executing a selfdestruct on a specific contract, resulting in ether being sent to that contract. This action is intended to break the target contract's balance-checking logic and allow you to successfully complete the level.

