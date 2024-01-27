pragma solidity ^0.8.0;

contract StorageHelper {
    function getArrayLocation(
        uint slot,
        uint index,
        uint elementSize
    ) public pure returns (bytes32) {
        return
            bytes32(
                uint256(keccak256(abi.encodePacked(slot))) +
                    (index * elementSize)
            );
    }

    function getMappingLocation(
        uint slot,
        uint key // change to key type
    ) public pure returns (bytes32) {
        return bytes32(uint256(keccak256(abi.encode(key, slot))));
    }
}
