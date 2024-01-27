# DexTwo

- Bug class: `Price manipulation`, `External call to untrusted contract`

Within this challenge, the `swap` function neglects to validate the `from` and `to` token addresses. This oversight opens a window of opportunity for attackers to exploit the vulnerability. By setting the `from` token to a malicious contract, an attacker gains the ability to manipulate the price of the `to` token as returned by the `getSwapAmount` function. This unchecked token swap vulnerability underscores the importance of meticulous input validation to secure decentralized exchange functionalities and prevent malicious actors from compromising the integrity of token swaps.
