# Fallout

- Bug Class: `Typo`

In this level, the vulnerability is related to a typo in the constructor. Due to this typo, the constructor was not called upon contract deployment. As a result, an attacker can exploit this situation by manually invoking the constructor, effectively setting the contract owner to themselves.

To exploit the Typo bug, we can manually call the constructor to set the owner to the attacker's address.