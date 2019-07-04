# Transaction management

## Introduction

Let's review some code examples on how to handle transactions with the Java client library:

* [Storing data](transaction-management.md#storing-data)
* [Retrieving data](transaction-management.md#retrieving-data)
* [Sending tokens](transaction-management.md#sending-tokens)
* [Retrieving tokens](transaction-management.md#retrieving-tokens)

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

## Sending tokens

To send an amount from my address to another address:

```java
Result result = api.sendTokens(tokenRRI, BigDecimal.valueOf(10.99), <to-address>);
result.blockUntilComplete();
```

Or equivalently,

```java
TransferTokensAction sendAction = TransferTokensAction.create(
  tokenRRI,
  api.getAddress(),
  <to-address>,
  BigDecimal.valueOf(10.00),
  null
);
Result result = api.execute(sendAction);
result.blockUntilComplete();
```

## Retrieving tokens

To retrieve all of the token transfers which have occurred in my account:

```java
Observable<TokenTransfer> transfers = api.observeTokenTransfers();
transfers.subscribe(tx -> { ... });
```

To get a stream of the balance of tokens in my account:

```java
Observable<BigDecimal> balance = api.observeBalance(tokenRRI);
balance.subscribe(bal -> { ... });
```

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

