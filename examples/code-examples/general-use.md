# General use

## Introduction

Let's review some code examples on how to handle generic tasks:

* [Initializing a Universe](general-use.md#initializing-a-universe)
* [Initializing the DApp API](general-use.md#initializing-the-dapp-api)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Initializing a Universe

To bootstrap to the **ALPHANET** test network:

```java
RadixUniverse.bootstrap(Bootstrap.ALPHANET);
```

To bootstrap to the **BETANET** test network:

```text
RadixUniverse.bootstrap(Bootstrap.BETANET);
```

{% hint style="info" %}
**Note:** No network connections will be made yet until it is required.
{% endhint %}

## Initializing the DApp API

The Radix Application API is a client-side API exposing high-level abstractions to make DApp creation easier.

To initialize the API:

```java
RadixUniverse.bootstrap(Bootstrap.ALPHANET); // This must be called before RadixApplicationAPI.create()
RadixApplicationAPI api = RadixApplicationAPI.create(identity);
```



