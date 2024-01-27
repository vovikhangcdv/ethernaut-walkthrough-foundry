# Reentrance

- Bug Class: `Reentrancy`

In this level, the vulnerability lies in the `withdraw` function, making it susceptible to a `Reentrancy` attack. The attacker can exploit this by calling `withdraw` to withdraw ether. Upon receiving ether, the fallback function of the attacker's contract is triggered, which in turn calls `withdraw` again, creating a loop of reentrant calls.

Exploiting this bug involves executing a reentrancy attack by strategically using the fallback function to repeatedly call the vulnerable `withdraw` function.

