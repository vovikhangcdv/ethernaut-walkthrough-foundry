# Privacy

- Bug class: `Storage Layout`

Using forge to see that the data is stored at slot 3, with offset 2. Then, the actually slot to `vm.load` is 5.

```bash
forge inspect instances/Ilevel12.sol:Privacy storageLayout --pretty
| Name         | Type       | Slot | Offset | Bytes | Contract                       |
|--------------|------------|------|--------|-------|--------------------------------|
| locked       | bool       | 0    | 0      | 1     | instances/Ilevel12.sol:Privacy |
| ID           | uint256    | 1    | 0      | 32    | instances/Ilevel12.sol:Privacy |
| flattening   | uint8      | 2    | 0      | 1     | instances/Ilevel12.sol:Privacy |
| denomination | uint8      | 2    | 1      | 1     | instances/Ilevel12.sol:Privacy |
| awkwardness  | uint16     | 2    | 2      | 2     | instances/Ilevel12.sol:Privacy |
| data         | bytes32[3] | 3    | 0      | 96    | instances/Ilevel12.sol:Privacy |
```
=> `bytes16 key = bytes16(vm.load(address(level12), bytes32(uint256(5))));`