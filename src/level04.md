# Telephone

- Bug Class: `tx.origin attacks`

In this level, the vulnerability is associated with `tx.origin` attacks. When the function `telephone.changeOwner(msg.sender)` is called, note that `msg.sender` refers to the address of inner caller, not the address of the origin EOA caller. Consequently, the owner is not changed to the caller's address as one might expect.

Exploiting this vulnerability involves understanding the distinction between `msg.sender` and `tx.origin`.