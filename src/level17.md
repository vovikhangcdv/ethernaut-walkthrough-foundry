# Recovery

- Bug class: `Internal transaction`

Using Explorer to observe the internal transaction, we can see that the contract create a new token contract. By calling `destroy()` function of the token contract, it will send all the ether to the owner of the token contract. Therefore, we can call `destroy()` to recover the ether.

Another method is compute the next address, please see more at [How is the address of an Ethereum contract computed?](https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed).
