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

## Storing data

Immutable data can be stored on the ledger. The data can be encrypted so that only selected identities can read the data.

To store the encrypted string `Hello` which only the user can read:

```java
Result result = api.sendMessage("Hello".getBytes(StandardCharsets.UTF_8), true);
result.blockUntilComplete();
```

To store the unencrypted string `Hello`:

```java
Result result = api.sendMessage("Hello".getBytes(StandardCharsets.UTF_8), false);
result.blockUntilComplete();
```

## Retrieving data

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

## Retrieving tokens

To retrieve all of the token transfers which have occurred in my account:

```java
Observable<TokenTransfer> transfers = api.getTokenTransfers();
transfers.subscribe(tx -> { ... });
```

To get a stream of the balance of tokens in my account:

```java
Observable<BigDecimal> balance = api.getBalance(tokenRRI);
balance.subscribe(bal -> { ... });
```

