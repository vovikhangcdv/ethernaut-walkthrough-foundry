pragma solidity ^0.8.0;
import "../instances/Ilevel26.sol";
import "forge-std/Script.sol";

contract Level26 is Script {
    DoubleEntryPoint level26 =
        DoubleEntryPoint(payable(0xDd52358C79735f90904FF27AeAE4E847F27e0755));

    LegacyToken legacyToken;
    CryptoVault cryptoVault;
    Forta forta;

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        legacyToken = LegacyToken(level26.delegatedFrom());
        cryptoVault = CryptoVault(level26.cryptoVault());
        forta = Forta(level26.forta());
        vm.startBroadcast(attackerPrivateKey);
        DetectionBot detectionBot = new DetectionBot(address(cryptoVault));
        forta.setDetectionBot(address(detectionBot));
        vm.stopBroadcast();
    }
}

contract DetectionBot is IDetectionBot {
    address private cryptoVault;

    constructor(address _cryptoVault) {
        cryptoVault = _cryptoVault;
    }

    function handleTransaction(address user, bytes calldata msgData) external {
        (, , address origSender) = abi.decode(
            msgData[4:],
            (address, uint256, address)
        );
        if (origSender == cryptoVault) {
            Forta forta = Forta(msg.sender);
            forta.raiseAlert(user);
        }
        // unintended solution:
        // Forta forta = Forta(msg.sender);
        // forta.raiseAlert(user);
    }
}
