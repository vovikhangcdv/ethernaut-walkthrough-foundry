# Elevator

- Bug Class: Logic (Understanding Contract Behaviors)

In this level, the vulnerability is related to logic, specifically in understanding the contract behaviors. Upon inspecting the code, we encounter a Building interface within the contract, indicating the need to implement a corresponding building contract.

Furthermore, in the `goTo` function, the building is instantiated by `msg.sender`, suggesting the requirement to create a building contract that can be invoked by the elevator contract.

Executing the Foundry test reveals the call flow leading to `msg.sender.isLastFloor`. Recognizing this pattern is crucial for resolving the challenge. The solution involves developing a building contract that can be called by the elevator contract. This building contract should incorporate an `isLastFloor` function, returning true when the specified floor is the last floor.

Understanding and implementing this logic is key to successfully overcoming the Elevator challenge.