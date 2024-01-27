# Motorbike

- Bug Class: `Proxy`, `Unprotected Upgradable Proxy`

In this level, the vulnerability encompasses both the `Proxy` pattern and an `Unprotected Upgradable Proxy`. The `Motorbike` serves as a proxy that delegates calls to the `Engine`. However, the implementation contract fails to disable the initializer function, providing an opportunity for an attacker to call it and set the owner of the implementation contract.

The attack involves invoking the initializer function and subsequently calling `upgradeToAndCall` to a malicious contract, which executes a `selfdestruct` on the implementation contract. While the `Motorbike` continues to delegate calls to the implementation contract, it's left bricked as the implementation contract has been destroyed.

For additional context and details on a similar vulnerability, you can refer to this [forum post](https://forum.openzeppelin.com/t/uupsupgradeable-vulnerability-post-mortem/15680).
