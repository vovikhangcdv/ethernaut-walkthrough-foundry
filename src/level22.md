# DEX

- Bug class: `Price manipulation`

Within this contract, the swap outcome amount is determined by the `x * y = k` formula. Here, `x` represents the DEX balance of Token 1, `y` signifies the DEX balance of Token 2, and `k` stands for the constant product of the two balances. This formula, rooted in the concept of the Constant Product Market Maker, ensures that the product of the two balances remains constant both before and after the swap.

However, a critical flaw emerges in the application of this formula. Instead of correctly utilizing the balances of the DEX after the swap to calculate the outcome swap amount, the contract erroneously employs the balances before the swap. Consequently, the outcome swap no longer aligns with the intended design, creating a vulnerability that an attacker can exploit to drain the DEX balance.

For a deeper understanding of the Constant Product Market Maker and the significance of balance calculation timing, refer to relevant resources. The highlighted flaw underscores the importance of precision in implementing mathematical models within smart contracts to maintain the integrity of decentralized exchanges.
