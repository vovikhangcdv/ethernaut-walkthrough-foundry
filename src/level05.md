# Token

- Bug Class: `Integer overflow`

The vulnerability in this level is related to an `Integer overflow`. By attempting to transfer more tokens than the balance of the sender, the sender's balance overflows and becomes an unexpectedly large number. This allows the sender to transfer tokens without actually losing any balance.

Exploiting this bug involves intentionally triggering the integer overflow to manipulate the token transfer process.

