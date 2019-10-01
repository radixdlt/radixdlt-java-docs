# Transaction management

## Introduction

Let's review some code examples on how to handle transactions with the Java client library:

* [Executing atomic transactions](transaction-management.md#executing-atomic-transactions)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Executing atomic transactions

To execute an atomic transaction of creating a token, minting, then sending:

```java
CreateTokensAction createAction = CreateTokenAction.create(
  tokenRRI,
  "Joshy Token",
  "The Best Coin Ever",
  BigDecimal.ZERO,
  TokenUnitConversions.getMinimumGranularity(),
  TokenSupplyType.MUTABLE
);

MintTokensAction mintAction = MintTokensAction.create(
  tokenRRI,
  api.getAddress(),
  BigDecimal.valueOf(1000000.0)
);

TransferTokensAction transferAction =  TransferTokensAction.create(
  tokenRRI,
  api.getAddress(),
  <to-address>,
  BigDecimal.valueOf(1000000.0),
  null
);

Transaction tx = api.createTransaction();
tx.stage(createAction);
tx.stage(mintAction);
tx.stage(transferAction);
Result result = tx.commitAndPush();
result.blockUntilComplete();

```

