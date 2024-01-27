# GoodSamaritan

- Bug Class: `External Call`, `Logic`

In the `GoodSamaritan` contract, users can `requestDonation` to receive 10 Coin. If the wallet balance is below 10 Coin, the contract transfers the remaining balance to the user.

However, a vulnerability arises in the `Coin` contract. When transferring Coin, it checks if the destination is a contract. If it is, the contract calls the `notify` function of the destination contract.

Exploiting this, a malicious contract can be created to call the `requestDonation` function of the `GoodSamaritan`, triggering a `NotEnoughBalance()` exception. Consequently, the `GoodSamaritan` transfers all the remaining balance to the malicious contract.
