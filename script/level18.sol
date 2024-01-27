pragma solidity ^0.8.0;
import "../instances/Ilevel18.sol";
import "forge-std/Script.sol";

contract Level18 is Script {
    MagicNum level18 = MagicNum(0x1c24105cB7c59B33D8B773d694c6b0c9Cf8eF4fF);

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        bytes
            memory bytecode = hex"600a8061000d6000396000f300602a60005260206000f3";
        address deployedContract;
        assembly {
            deployedContract := create(0, add(bytecode, 0x20), mload(bytecode))
            if iszero(extcodesize(deployedContract)) {
                revert(0, 0)
            }
        }
        level18.setSolver(deployedContract);
        (bool result, bytes memory data) = deployedContract.call(
            abi.encodeWithSignature("whatIsTheMeaningOfLife()")
        );
        require(abi.decode(data, (uint256)) == 42, "wrong answer");
        vm.stopBroadcast();
    }
}
