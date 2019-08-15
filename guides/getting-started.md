# Getting started

## Introduction

In this guide, we'll build a small distributed App \(DApp\) from the ground up using the [Java client library](https://github.com/radixdlt/radixdlt-java). The techniques you’ll learn in this tutorial are fundamental to make any DApp on [Radix](http://www.radixdlt.com/), and mastering it will give you a better understanding of the Radix distributed ledger.

The guide is divided into several sections:

* **​**[**Basic Setup**](getting-started.md#basic-setup) will give you a starting point to follow the tutorial.
* **​**[**Overview**](getting-started.md#basic-setup) will teach you the fundamentals of Radix's architecture.
* **​**[**Creating an ERC-like Token**](getting-started.md#creating-an-erc-like-token) will show you how to make your first basic DApp.
* **​**[**Beyond the basics**](getting-started.md#beyond-the-basics) will give you additional examples to acquire a deeper understanding of the Java library.

### About our example DApp

As our example DApp for this guide, we'll be building a simple ChatBot that receives and replies messages sent to a specific Radix address. With our small ChatBot DApp you'll learn to:

* Create a Radix [Identity](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#identity)
* Bootstrap and initialize the application API
* Create a Radix Resource Identifier \(RRI\)
* Create and mint an ERC-like token

Don't worry if you're new to Radix's concepts, as we will review the basic building blocks along the way.

## Basic setup

Our first step is to set you up so you can start building your first Java DApp with Radix.

### Installation

You can install the **`radixdlt-java`** library via gradle:

```java
repositories {
    jcenter()
    maven { url 'https://jitpack.io' }
}
```

```java
implementation 'com.radixdlt:radixdlt-java:dbfd5064e5'
implementation 'io.reactivex.rxjava2:rxjava:2.1.14'
```

### Recommendations

For this guide, we will assume that you have some familiarity with Java, but you should be able to follow along even if you’re coming from a different programming language.

{% hint style="success" %}
If you need to review Java, we recommend reading [this guide](https://www.learnjavaonline.org/).
{% endhint %}

We’ll also assume that you’re familiar with programming concepts like functions, objects, arrays, and classes. Additionally, knowledge of reactive and observable patterns is helpful but not required.

## Overview

Now that you’re set up, feel free to review our glossary so we can share a common language:

{% hint style="success" %}
**Tip:** if you're new to Radix we suggest to take a minute and dig into the concepts that make Radix a unique distributed ledger technology.
{% endhint %}

* [Universe](https://docs.radixdlt.com/alpha/learn/glossary#universe)
* [Shards](https://docs.radixdlt.com/alpha/learn/glossary#shard)
* [Nodes](https://docs.radixdlt.com/alpha/learn/glossary#nodes)
* [Atoms](https://docs.radixdlt.com/alpha/learn/glossary#atoms)
* [Account](https://docs.radixdlt.com/alpha/learn/glossary#account)
* [Address](https://docs.radixdlt.com/alpha/learn/glossary#address)
* [Identity](https://docs.radixdlt.com/alpha/learn/glossary#identity)

## Creating an ERC-like token

Now that we have done a brief overview of the concepts behind Radix and we share a common language, we are ready to begin building our example Token DApp using the **`radixdlt-java`** library.

### Creating a Radix Identity

The first step is to create an identity based on a set of public and private keys. This identity will handle the private/public key logic on behalf of the DApp.

We start by generating an ephemeral identity using the `RadixIdentities.createNew()` method:

```java
//...
RadixIdentity identity = RadixIdentities.createNew();
```

### Initializing the API

Next, we initialize the API by using our identity and selecting to bootstrap into the desired network. In this case, we will use the **BETANET** universe configuration since it's our main testing environment.

We initialize the application API by calling the `RadixApplicationAPI.create()` method:

```java
//...
RadixIdentity identity = RadixIdentities.createNew();

RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.BETANET, identity);
```

### Creating an RRI

Every resource on the Radix Ledger is globally identified by a unique RRI \(Radix Resource Identifier\). In our case, the token we will create will have an RRI of `/<address>/TOKEN`.

We create a token RRI by executing the `RRI.of()` method:

```java
//...
RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.BETANET, identity);

RRI tokenRRI = RRI.of(api.getAddress(), "TOKEN");
```

### Creating and minting a Token on ledger

With the defined RRI we are ready to:

* create a multi-issuance token with the `api.createMultiIssuanceToken()` method
* mint our tokens by executing `api.mintTokens()`

```java
//...
RRI tokenRRI = RRI.of(api.getAddress(), "TOKEN");

api.createMultiIssuanceToken(tokenRRI, "Cool Token", "The Best Token!").blockUntilComplete();
api.mintTokens(tokenRRI, BigDecimal.valueOf(1000000.00)).blockUntilComplete();
```

### Sending Tokens

Now that we have tokens on the ledger, we can send some tokens to any other address using `api.sendTokens()` :

```java
//...
RRI tokenRRI = RRI.of(api.getAddress(), "TOKEN");

RadixAddress toAddress = api.getAddress(RadixIdentities.createNew().getPublicKey());
api.sendTokens(tokenRRI, toAddress, BigDecimal.valueOf(10.99)).blockUntilComplete();
```

### Finishing touches

At this point, we have all the basic building blocks for our simple Token DApp. Now, to have a complete and functional DApp, let's add some finishing touches:

* Add the required imports
* Build a `main()` method to run and test by sending a few tokens to another address
* Print out some basic information

```java
import java.math.BigDecimal;

import com.radixdlt.client.application.RadixApplicationAPI;
import com.radixdlt.client.application.identity.RadixIdentities;
import com.radixdlt.client.application.identity.RadixIdentity;
import com.radixdlt.client.atommodel.accounts.RadixAddress;
import com.radixdlt.client.core.Bootstrap;
import com.radixdlt.client.core.atoms.particles.RRI;

public class CreateToken {
  public static void main(String[] args) {
    // Create an ephemeral identity
    RadixIdentity identity = RadixIdentities.createNew();
    RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.BETANET, identity);

    System.out.println("My address: " + api.getAddress());
    System.out.println("My public key: " + api.getPublicKey());

    // Create and mint tokens
    RRI tokenRRI = RRI.of(api.getAddress(), "TOKEN");
    api.createMultiIssuanceToken(tokenRRI, "Cool Token", "The Best Token!").blockUntilComplete();
    api.mintTokens(tokenRRI, BigDecimal.valueOf(1000000.00)).blockUntilComplete();

    // Observe my current and future total balance
    api.observeBalance(tokenRRI)
      .subscribe(balance -> System.out.println("My Balance: " + balance));

    // Create another ephemeral address
    RadixAddress toAddress = api.getAddress(RadixIdentities.createNew().getPublicKey());
    System.out.println("Receiver address: " + toAddress);
    System.out.println("Receiver public key: " + toAddress.getPublicKey());
    
    // Observe the receiver's future total balance
    api.observeBalance(toAddress, tokenRRI)
      .subscribe(balance -> System.out.println("Receiver Balance: " + balance));
         
    // Send tokens to the receiver ephemeral address
    api.sendTokens(tokenRRI, toAddress, BigDecimal.valueOf(10.99)).blockUntilComplete();

    System.out.println("Finished!");
    System.exit(0);
  }
}
```

Running this code will produce an output similar to this:

```text
My address: 9hBfXVvWYjmVaLtZ9XG8FMdx68eeZeXwXMTwmiUiEjcia5d4sh9
My public key: A18L50ar+I5gLSxQur0h8KtQP4WTUvMsgp8rFHtn9Mks
My Balance: 1000000.000000000000000000
Receiver address: 9gAhSHstFvfuMk76zr6xFHxsP8owwHdebkgjvduM8a8gggCXpaH
Receiver public key: AtknkWX83wzv0wO29RHIjceEjLK7fHSlmBhyZ2m+kzD2
My Balance: 999989.010000000000000000
Receiver Balance: 10.990000000000000000
Finished!
```

Congratulations! You have now created, minted and sent an ERC-like Token using the Radix Network.

## Beyond the basics

As we reach the end of our DApp example, we want to share some extra code snippets for those who want to go beyond the basics and showcase a few additional things that you can do with our library.

### Code examples

* [General use](../examples/code-examples/general-use.md)
* [Identity management](../examples/code-examples/identity-management.md)
* [Message management](../examples/code-examples/message-management.md)
* [Transaction management](../examples/code-examples/transaction-management.md)
* [Token management](../examples/code-examples/token-management.md)

