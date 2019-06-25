# Identity management

## Introduction

Let's review some code examples on how to handle identities with the Java client library:

* [Creating an Identity](identity-management.md#creating-an-identity)
* [Generating an Address](identity-management.md#generating-an-address)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Creating an Identity

To create or load an identity from a file:

```java
RadixIdentity identity = RadixIdentities.loadOrCreateEncryptedFile("filename.key", "password");
```

This will either create or load a file with a public/private key and encrypted with the given password.

## Generating an Address

An address is a reference to an account and allows a user to receive tokens and/or data from other users.

You can get your own address by:

```java
RadixAddress myAddress = api.getMyAddress();
```

Or from a base58 string:

```java
RadixAddress anotherAddress = RadixAddress.fromString("JHB89drvftPj6zVCNjnaijURk8D8AMFw4mVja19aoBGmRXWchnJ");
```

