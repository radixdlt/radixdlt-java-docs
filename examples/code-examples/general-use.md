# General use

## Introduction

Let's review some code examples on how to handle generic tasks:

* [Initializing a Universe](general-use.md#initializing-a-universe)
* [Initializing the Application API](general-use.md#initializing-the-dapp-api)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Initializing a Universe

A Universe is an instance of a Radix Distributed Ledger which is defined by a genesis atom and a dynamic set of unpermissioned nodes forming a network.

### Available networks

| Network | Description |
| :--- | :--- |
| `LOCALHOST_SINGLENODE` | A locally hosted single node connection. |
| `BETANET_SINGLENODE` | A single node Betanet connection. |

A predefined configuration to bootstrap into the **LOCALHOST\_SINGLENODE** network is available:

```java
BootstrapConfig config = Bootstrap.LOCALHOST_SINGLENODE;
```

## Initializing the Application API

The Radix Application API is a client-side API exposing high-level abstractions to make DApp creation easier.

To initialize the API:

```java
RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.BETANET, identity);
```

To continually sync and pull from the network ledger on your account:

```java
Disposable d = api.pull();
```

To stop syncing:

```java
d.dispose();
```

