# GatekeeperOne

- Bug class: `Unsafe Downcasting`, `tx.origin Bypass`

## Gate One

To bypass the require(msg.sender != tx.origin); check, we can leverage a separate exploit contract. By deploying this exploit contract, we can separate msg.sender and tx.origin, successfully bypassing the check.

## Gate Two

In order to pass through Gate Two, it is necessary to set the gas value divisible by 8191. Instead of calculating the gas, we can opt for a brute force approach using the call function with the gas parameter.

## Gate Three

Understanding each requirement is crucial for success. If you are not famliar with type conversions in Solidity, I recommend reading [this](https://docs.soliditylang.org/en/latest/types.html#conversions-between-elementary-types) first.

The function reviews a bytes8 key as input, assuming it follows the format `(1)|(2)|(3)|(4)|(5)|(6)|(7)|(8)`. The function checks the key against the following requirements:

### Requirement 1

First requirement: `uint32(uint64(_gateKey)) == uint16(uint64(_gateKey))`, implying the last 4 bytes of the key must match the last 2 bytes. Therefore:
```
(5)|(6)|(7)|(8) == (7)|(8)
=> (5)|(6) == "0x0000"
```
### Requirement 2

Next requirement: `uint32(uint64(_gateKey)) != uint64(_gateKey)`. This means the first 4 bytes of the key must differ from the last 4 bytes. Consequently:
```
(1)|(2)|(3)|(4) != (5)|(6)|(7)|(8)
```
Considering that `(5)|(6) == "0x0000"`, it suffices to ensure `(1)|(2) != "0x0000"`.

### Requirement 3

The final requirement is `uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))`, indicating the last 4 bytes of the key must match the last 2 bytes of `tx.origin`. Given that `(5)|(6) == "0x0000"`, we only need to set `(7)|(8)` equal to the last 2 bytes of `tx.origin`.

### Putting it all together

So far, we have the key `(1)|(2)|(3)|(4)|(5)|(6)|(7)|(8)` with `(5)|(6) == "0x0000"`, `(1)|(2) != "0x0000"`, and `(7)|(8)` equal to the last 2 bytes of `tx.origin`. Let's create it!

```solidity
bytes8 _gateKey = bytes8(
    uint64(uint16(uint160(tx.origin))) |
    uint64(bytes8(0xff00000000000000))
);
```