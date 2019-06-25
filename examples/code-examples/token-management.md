# Token management

## Introduction

Let's review some code examples on how to handle tokens with the Java client library:

* [Creating a token](token-management.md#creating-a-token)
* [Minting tokens](token-management.md#minting-tokens)
* [Getting a token's resource identifier](token-management.md#getting-a-tokens-resource-identifier)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

{% hint style="warning" %}
**NOTE:** these examples requires **BETANET** network access.
{% endhint %}

## Creating a token 

To create your own token on Radix, you can use the `createToken(...)` method provided by the Java DApp API:

```java
api.createToken(<token_name>, <iso_name>, <description>, 
    <amount>, TokenUnitConversions.getMinimumGranularity(), 
    TokenSupplyType.MUTABLE);
```

For example, to create 10000 UST tokens:

```java
api.createToken(
    "UST Example Token",                              // Name
    "UST",                                         // ISO
    "This is a token created by me",               // Description
    BigDecimal.valueOf(10000),                     // Amount
    TokenUnitConversions.getMinimumGranularity(),  // Granularity: Default is 10^18
    TokenSupplyType.MUTABLE                        // TokenSupplyType
)
```

## Minting tokens

When you need to mint new tokens, you can simply call the `mintTokens(...)` method as shown below:

```java
api.mintTokens(<iso_token_name>, <amount_to_mint>);
```

## Getting a token’s Resource Identifier

To get the Radix Resource Identifier \(RRI\) for a token created by a previous call to `createToken(...)`, we have to:

```java
RRI myRRid = RRI.of(api.getMyAddress(), <iso_token_name>);
```

{% hint style="info" %}
**Note:** no validation is made whether the returned RRI actually points to a valid token in the internal address space of the client.
{% endhint %}

