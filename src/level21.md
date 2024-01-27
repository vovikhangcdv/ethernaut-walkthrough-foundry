# Shop

- Bug Class: `External Call`

In this level, the vulnerability is associated with an `External Call`. The contract obtains the price from an external contract, and the sender has control over this external contract. Consequently, the sender can manipulate the price, setting it to 0 and essentially acquiring the item for free.

Even if the interface of the `price` function is marked as view, exploiting this bug involves creating a non-view function that aligns with the interface. This non-view function can then be used to manipulate the price and facilitate a free purchase.

Understanding and leveraging this external call vulnerability is crucial to successfully navigating the Shop challenge.

