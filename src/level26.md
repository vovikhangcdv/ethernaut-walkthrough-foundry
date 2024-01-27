# DoubleEntryPoint

- Bug class: `Detection`, `Logic`

The `LegacyToken` and the `DoubleEntryPoint` token maintain a tight connection: when a transfer is initiated for the `LegacyToken`, it delegates the call to transfer tokens to `DoubleEntryPoint`. This dynamic creates an avenue for attackers to exploit the `sweepToken` function in `CryptoVault`, enabling them to transfer all underlying tokens from `DoubleEntryPoint`.

Our mission revolves around crafting a Detection Bot contract, triggered whenever `DoubleEntryPoint` is called. This bot is designed to `raiseAlert` upon detecting any malicious calls that could potentially drain the funds of the `cryptoVault`.

To achieve this, we can develop a malevolent Detection Bot that scrutinizes whether the `origSender` matches the `cryptoVault`. If there is a match, the bot promptly raises an alert, serving as a safeguard against potential attacks.

## Potential Unintended Solution

It's worth noting that the level's validation is somewhat limited. While it checks whether the attack payload should revert or not, it doesn't verify the functionality of normal payloads, such as sweeping other tokens. This oversight opens an avenue to craft a Detection Bot that consistently raises an alert, allowing the level to be passed. However, it's crucial to recognize that this approach deviates from the main solution and provides limited learning insights about the level.
