pragma solidity ^0.8.0;

import "../instances/Ilevel00.sol";
import "forge-std/Test.sol";

contract Attacker is Test {
    Instance level0 = Instance(0xd974C1CDF7D0397a8aF7CB41346d61CbEC7C8A6f);

    function test() external {
        // vm.startBroadcast();
        level0.password();
        level0.authenticate(level0.password());
        require(level0.getCleared() == true, "not cleared");
        // vm.stopBroadcast();
    }
}
