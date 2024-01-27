# Prevervation

- Bug class: `delegatecall`, `proxy`, `storage layout`

The contract Preservation serves as a proxy, delegating all calls to the implementation contracts (timezone library 1 and 2). Despite the presence of set time functions that delegatecall to the two implementation contracts, a critical mistake lies in the mismatched storage layout between the implementation contracts and the proxy contract. This discrepancy opens up an opportunity to exploit the delegatecall mechanism and manipulate the storage of the proxy contract.

The exploitation strategy involves using delegatecall to invoke the setTime function of the implementation contracts, thereby modifying the storage of the proxy contract.

The overarching plan is to manipulate the storage of the proxy contract by overwriting the timeZone1Library slot with the address of a new malicious implementation contract. Subsequently, the exploit abuses the `setFirstTime()` function to trigger a delegate call to the malicious contract, thereby overwriting the owner slot.

For a detailed walkthrough, refer to the exploit script provided.