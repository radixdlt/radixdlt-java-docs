# Token management

## Introduction

Let's review some code examples on how to handle tokens with the Java client library:

* [Creating a token](token-management.md#creating-a-token)
* [Minting tokens](token-management.md#minting-tokens)
* [Burning tokens](token-management.md#burning-tokens)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Creating a token 

To create a token, an RRI \(Radix Resource Identifier\) must first be constructed:

```java
RRI tokenRRI = RRI.of(api.getMyAddress(), "NEW");
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

## Minting tokens

To mint 1000 tokens \(must be multi-issuance\) in your account:

```java
Result result = api.mintTokens(tokenRRI, BigDecimal.valueOf(1000.0));
result.blockUntilComplete();
```

## Burning tokens

To burn 1000 tokens \(must be multi-issuance\) in your account:

```java
Result result = api.burnTokens(tokenRRI, BigDecimal.valueOf(1000.0));
result.blockUntilComplete();
```

