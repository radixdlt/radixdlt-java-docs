# Atom management

## Introduction

Let's review some code examples on how to handle atoms with the Java client library:

* [Signing an atom](atom-management.md#signing-an-atom)
* [Submitting an atom to the ledger](atom-management.md#submitting-an-atom-to-the-ledger)
* [Sending an atom as a message](atom-management.md#sending-an-atom-as-message)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Signing an Atom 

To sign an unsigned atom using the current account's signature, use the Identity’s `sign(...)` method:

```java
Atom mySignedAtom = api.getMyIdentity().sign(<my_unsigned_atom>);
```

## Submitting an Atom to the ledger

To submit an atom to the ledger, just use the API’s `submitAtom(...)` method:

```java
api.submitAtom(<my_atom>);
```

## Sending an Atom as message

In the following example, we serialize an atom and send it as a message to a destination address:

```java
String address = “JHB89drvftPj6zVCNjnaijURk8D8AMFw4mVja19aoBGmRXWchnJ”;
byte[] data = atom.toDson();
RadixAddress receiver = RadixAddress.from(address);

api.sendMessage(data, false, receiver);
```

{% hint style="info" %}
**Note:** this method does not submit the atom to the ledger. It only sends it as an arbitrary data byte array. There is no validation performed on the atom.
{% endhint %}

