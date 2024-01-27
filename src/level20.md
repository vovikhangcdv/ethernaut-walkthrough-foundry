# Denial

- Bug class: `Denial of Service (DOS)`, `Gas Limit`

Given that the `call()` will not revert on failure, but it still cost gas, we can use it to consume all the gas in the transaction, and make the transaction revert.
