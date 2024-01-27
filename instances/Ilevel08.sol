// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    bool public locked;
    bytes32 private password;
    // Test data types
    // mapping(address => uint256) private balances;
    // bytes private data;
    // uint64 a;
    // uint64 b;
    // uint256 c;
    // string private name;
    // uint256[3] private fixedArray;
    // uint256[][] private dynamicArray;
    struct S {
        uint16 a;
        uint16 b;
        uint256 c;
    }
    uint x;
    mapping(uint => mapping(uint => S)) data2;

    //fixed array

    constructor(bytes32 _password) {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
            locked = false;
        }
    }
}
