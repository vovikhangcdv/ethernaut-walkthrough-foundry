# MagicNum

- Bug class: `Assembly`, `Bytecode`.

I highly recommend gaining insights into the inner workings of the EVM before delving into this level. Refer to the  [References](#references) section for additional reading.

To successfully solve this level, follow the provided instructions. The challenge lies in supplying the contract with the address of another contract that responds with `42` upon calling `whatIsTheMeaningOfLife()`. However, the twist is that the solver's code must be exceptionally compact—limited to a mere 10 opcodes.

Let's explore what can be achieved within these constraints.

In essence, when creating a contract, an initialization code is required. This code executes once during contract creation and must return the deployed bytecode, which subsequently runs upon each call to the contract.

Given this knowledge, we can construct a contract designed to unfailingly return 42 regardless of the input or invoked function. Since the function selector is a byproduct of the compiler's injected code logic, we can circumvent it by manually creating a contract, focusing solely on the task of returning 42.

Here is the bytecode for a contract that returns 42:

```assembly
// return 42
PUSH1 0x2a // push 42 to the stack
PUSH1 0x00 // offset of the memory to store the value
MSTORE // store the value in memory
PUSH1 0x20 // length of the value
PUSH1 0x00 // offset of the value in memory
RETURN // return the value from memory
```

This bytecode serves as the deployed contract's logic.

Now, to create the initialization code that returns this bytecode, we employ the codecopy opcode:

```assembly
push1 0x0a // length of the deployed bytecode
dup1
push2 0x000d // offset of the deployed bytecode in this initialization code
push1 0x00 // offset of the deployed bytecode to store in memory
codecopy // copy the deployed bytecode to memory
push1 0x00 // offset of the deployed bytecode in memory, which will be the return offset
return // return the deployed bytecode from memory
stop
// return 42
PUSH1 0x2a // push 42 to the stack
PUSH1 0x00 // offset of the memory to store the value
MSTORE // store the value in memory
PUSH1 0x20 // length of the value
PUSH1 0x00 // offset of the value in memory
RETURN // return the value from memory
```
To convert these opcodes into bytecode, you can use [EVM.codes](https://evm.codes).

The resulting bytecode is: `600a8061000d6000396000f300602a60005260206000f3`.

Now, deploy a contract with this bytecode as the initialization code and call `whatIsTheMeaningOfLife()`. Deploying the bytecode can be achieved through methods like `create`, `create2` opcodes, or by sending a transaction with the data field containing the bytecode to the null address.

## References

-   https://blog.trustlook.com/understand-evm-bytecode-part-1/
-   https://ardislu.dev/raw-bytecode-evm
