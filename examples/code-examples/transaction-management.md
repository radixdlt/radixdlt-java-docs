# Transaction management

## Introduction

Let's review some code examples on how to handle transactions with the Java client library:

* [Sending messages](transaction-management.md#storing-data)
* [Receiving messages](transaction-management.md#retrieving-data)
* [Executing atomic transactions](transaction-management.md#executing-atomic-transactions)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Sending messages

Immutable data can be stored on the ledger. The data can be encrypted so that only selected identities can read the data.

To send the encrypted string `Hello` which only the sender and recipient can read:

```java
Result result = api.sendMessage(<to-address>, "Hello".getBytes(StandardCharsets.UTF_8), true);
result.blockUntilComplete();
```

To send the unencrypted string `Hello`:

```java
Result result = api.sendMessage(<to-address>, "Hello".getBytes(StandardCharsets.UTF_8), false);
result.blockUntilComplete();
```

Or equivalently,

```java
SendMessageAction msgAction = SendMessageAction.create(api.getAddress(), <to-address>, "Hello".getBytes(StandardCharset.UTF_8), false);
Result result = api.execute(msgAction);
result.blockUntilComplete();
```

## Receiving messages

To read \(and decrypt if necessary\) all the readable data at an address:

```java
Observable<DecryptedMessage> readable = api.getMessages();
readable.subscribe(data -> { ... });
```

{% hint style="info" %}
**Note:** data that can't be decrypted by the user's key is simply ignored.
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

