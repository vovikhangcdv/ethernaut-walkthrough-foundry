# Puzzle Wallet

- Bug class: `Upgradeable Contract`, `Storage layout`, `delegatecall`

The Puzzle Wallet exposes vulnerabilities stemming from an intricate interplay of states and functions. The proxy contract possesses two critical state variables, namely `pendingAdmin` and `admin`, which overlap with the implementation contract's state variables: `owner` and `maxBalance`.

Let's dissect the contract flow for a clearer understanding:

- (1). **Objective:** Our goal is to write an arbitrary value to the `maxBalance` variable, achievable exclusively through the `setMaxBalance` function.

- (2). The `setMaxBalance` function is constrained to be callable only when the contract's balance is 0.

- (3). This function can solely be invoked by a `whitelisted` address. The `whitelisted` addresses are added through the `addToWhitelist` function, a privilege granted only to the `owner` address.

- (4). The `owner` address is established via the `init` function, an operation permitted only once.

Now, let's delve into the exploitation strategy:

- (4). Leveraging the overlap of the `owner` slot with the `pendingAdmin` slot, set `pendingAdmin` to the attacker's address using the `proposeNewAdmin` function.

- (3). As the new `owner`, call `addToWhitelist` to add the attacker's address to the `whitelisted` list.

- (2). Exploit the `multicall`, `execute`, and `deposit` functions. The `whitelisted` address can use the `deposit` function to increase their ETH balance in the contract. The `execute` function transfers all the ETH in the contract to a specified address.

    - Call the `multicall` function in a nested loop to invoke the `deposit` function multiple times. Despite the `depositCalled` variable aiming to prevent this, it can be bypassed by nesting multicalls, allowing us to accumulate ETH balances extensively.

    - Once ETH balances are claimed, call `execute` to deplete the contract balance to 0.

- (1). With the contract balance now at 0, invoke `setMaxBalance` to write an arbitrary value to the attacker's address.

This intricate series of steps exploits the nuanced storage layout and function interactions in the Puzzle Wallet, emphasizing the critical importance of thorough security measures in upgradeable contracts.