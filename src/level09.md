# King

- Bug Class: `Denial of Service (DOS)`

In this level, the vulnerability is related to `Denial of Service (DOS)`. Exploiting this bug involves using an intermediate contract to call `king.call.value(1 ether)()` and become the king. The critical point here is that the current king, lacking a fallback function, cannot receive ether. Consequently, the game contract becomes stuck for the next player.

## Exploiting the Bug

To exploit this vulnerability:

1. Use an intermediate contract without receive or fallback functions.
2. Call `king.call.value(1 ether)()` using the intermediate contract.
3. Become the king.

This action prevents the current king from receiving ether and results in a denial of service, effectively trapping the game contract for the subsequent player.

