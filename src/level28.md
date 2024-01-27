# Gatekeeper Three

- Bug class: `Send Ether`, `Logic`

This challenge serves as a comprehensive test of Solidity knowledge, requiring a step-by-step approach to navigate through each gate and unravel its intricacies.

-   **Gate 1:** The `construct0r` function harbors a typo, providing an opening for exploitation. By invoking `construct0r`, we can effectively set the `msg.sender` as the owner of the contract. However, an additional condition requires the exploit to be written in a separate contract since `tx.origin != owner`.

-   **Gate 2:** The condition for passing this gate is `allowEntrance == true`. A deeper dive into the codebase reveals that this is set by the `getAllowance` function. To successfully navigate this gate, initiate the trick by calling `createTrick`. To obtain the correct `password`, two methods can be employed:

    -   **Method 1:** Extract the storage slot of the private password.
    -   **Method 2:** Exploit the fact that the `checkPassword()` function sets a new password as `block.timestamp` when false. By incorrectly calling `getAllowance()` once in a single exploit transaction, the subsequent password will be the `block.timestamp` of that particular exploit transaction.

-   **Gate 3:** This gate necessitates transferring more than 0.001 Ether to the Gatekeeper and ensuring the `send` condition returns false. This is achieved by crafting a malicious `receive` function designed to run out of gas, causing it to fail and return false.
