# Alien Codex

- Bug class: `Underflow`, `Storage layout`, `Array Length Assignment (Slither Detector)`

To exploit the vulnerabilities in the Alien Codex contract, we will focus on the Underflow, Storage Layout, and the Array Length Assignment bugs. Specifically, we will manipulate the codex array to gain unauthorized access to arbitrary storage slots, allowing us to overwrite critical data.

## Step 1: Underflow the codex Array
Call the `retract()` function to trigger an underflow, reducing the length of the codex array to the maximum value of uint256. This manipulation enables access to any index within the array.

## Step 2: Calculate the index

Since the _owner and contact variables share the same slot, we can overwrite both values simultaneously. Calculate the index to access slot 0 by manipulating the slot pointer in the overflow scenario. Utilize the following formula:

Given our target slot is 0, or in case overflow, it will be `max + 1`. Additionally, we know that the slot of `codex` is 1. Therefore:
```
    max + 1 = keccak256(slot) + index 
    => index = max + 1 - keccak256(slot)
```
where the slot is the slot of the codex array (in this case, 1).

## Step 3: Craft the payload
Follow the [Solidity documentation on Packed Rules](https://docs.soliditylang.org/en/latest/internals/layout_in_storage.html#layout-of-state-variables-in-storage), ensuring that the 20 bytes of the owner address are stored in the **_lower-order__** part of the slot, and the contact bool variable is stored at the 12th byte. Craft the payload accordingly:

```solidity
        bytes32 payload = bytes32(uint256(uint160(attacker))) |
            bytes32(uint256(0x01) << 160);
```

## Step 4: Exploit
Call the revise function with the crafted payload and the index calculated in steps 1 and 2. This action will overwrite the targeted slot, effectively compromising the _owner and contact variables. To complete the challenge, set contact to true.

By following these steps, you can exploit the vulnerabilities in the Alien Codex contract and achieve the desired outcome.