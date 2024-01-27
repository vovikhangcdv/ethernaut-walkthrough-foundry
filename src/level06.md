# Delegation

- Bug Class: `Delegation`

In this level, the vulnerability lies in the delegation process. By making an arbitrary `delegatecall` to `Delegate.pwn()`, the `owner` is set to `msg.sender`. This manipulation allows the caller to take control of the delegation process and potentially exploit the contract.

To successfully exploit the bug, perform an arbitrary `delegatecall` to the specific function mentioned, thereby setting the `owner` to the address of the caller.

