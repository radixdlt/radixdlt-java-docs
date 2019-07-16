# Token management

## Introduction

Let's review some code examples on how to handle tokens with the Java client library:

* [Creating a token](token-management.md#creating-a-token)
* [Minting tokens](token-management.md#minting-tokens)
* [Burning tokens](token-management.md#burning-tokens)
* [Sending tokens](token-management.md#sending-tokens)
* [Retrieving tokens](token-management.md#retrieving-tokens)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide]().
{% endhint %}

## Creating a token 

To create a token, an RRI \(Radix Resource Identifier\) must first be constructed:

```java
RRI tokenRRI = RRI.of(api.getAddress(), "NEW");
```

{% hint style="info" %}
**Note:** no validation is made whether the returned RRI actually points to a valid token in the internal address space of the client.
{% endhint %}

To create a fixed-supply token:

```java
Result result = api.createFixedSupplyToken(tokenRRI, "New Token", "The Best Token", BigDecimal.valueOf(1000.0));
result.blockUntilComplete();
```

To create a multi-issuance token:

```java
Result result = api.createMultiIssuance(tokenRRI, "New Token", "The Best Token");
result.blockUntilComplete();
```

Or equivalently,

```java
CreateTokenAction createAction = CreateTokenAction.create(
  tokenRRI,
  "New Token",
  "The Best Token",
  BigDecimal.ZERO,
  TokenUnitConversions.getMinimumGranularity(),
  TokenSupplyType.MUTABLE
); 
Result result = api.execute(createAction);
result.blockUntilComplete();
```

## Minting tokens

To mint 1000 tokens \(must be multi-issuance\) in your account:

```java
Result result = api.mintTokens(tokenRRI, BigDecimal.valueOf(1000.0));
result.blockUntilComplete();
```

Or equivalently,

```java
MintTokensAction mintAction = MintTokensAction.create(tokenRRI, api.getAddress(), BigDecimal.valueOf(1000.0));
Result result = api.execute(mintAction);
result.blockUntilComplete();
```

## Burning tokens

To burn 1000 tokens \(must be multi-issuance\) in your account:

```java
Result result = api.burnTokens(tokenRRI, BigDecimal.valueOf(1000.0));
result.blockUntilComplete();
```

Or equivalently,

```java
BurnTokensAction burnAction = BurnTokensAction.create(tokenRRI, api.getAddress(), BigDecimal.valueOf(1000.0));
Result result = api.execute(burnAction);
result.blockUntilComplete();
```

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

