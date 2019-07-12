# Getting started

## Introduction

In this guide, we'll build a small distributed App \(DApp\) from the ground up using the [Java client library](https://github.com/radixdlt/radixdlt-java). The techniques you’ll learn in this tutorial are fundamental to make any DApp on [Radix](http://www.radixdlt.com/), and mastering it will give you a better understanding of the Radix distributed ledger.

The guide is divided into several sections:

* **​**[**Basic Setup**](getting-started.md#basic-setup) will give you a starting point to follow the tutorial.
* **​**[**Overview**](getting-started.md#overview) will teach you the fundamentals of Radix's architecture.
* **​**[**Building a ChatBot**](getting-started.md#building-a-chatbot) will show you how to make your first basic DApp.
* **​**[**Beyond the basics**](getting-started.md#beyond-the-basics) will give you additional examples to acquire a deeper understanding of the Java library.

### About our example DApp

As our example DApp for this guide, we'll be building a simple ChatBot that receives and replies messages sent to a specific Radix address. With our small ChatBot DApp you'll learn to:

* Bootstrap and connect to the Radix Distributed Ledger
* Create a Radix [Identity](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#identity)
* Create a Radix [Address](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#address) from this identity
* Send and receive encrypted messages to other Radix addresses

Don't worry if you're new to Radix's concepts, as we will review the basic building blocks along the way.

## Basic setup

Our first step is to set you up so you can start building your first Java DApp with Radix.

### Installation

You can install the **`radixdlt-java`** library via gradle:

```java
repositories {
    maven { url 'https://jitpack.io' }
}
```

```java
implementation 'com.radixdlt:radixdlt-java:0.9.3'
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

* [Universe](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#universe)
* [Shards](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#shard)
* [Nodes](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#nodes)
* [Atoms](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#atoms)
* [Account](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#account)
* [Address](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#address)
* [Identity](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#identity)

## Building a ChatBot

Now that we have done a brief overview of the concepts behind Radix and we share a common language, we are ready to begin building our example ChatBot DApp using the **`radixdlt-java`** library.

### Connecting to the network

The first step, before we can interact with the ledger, is to choose which [Universe](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/guides/get-started.md#universe) we want to connect to. In this case, we will use the **BETANET** universe configuration since it's our main testing environment.

We start by creating a ChatBot class and initializing the connection to a Radix Universe using the `RadixUniverse.bootstrap()` method:

```java
import com.radixdlt.client.core.RadixUniverse;

public class ChatBot {
    static {
        RadixUniverse.bootstrap(Bootstrap.BETANET);
    }

    public ChatBot() {
    }
}
```

This will initialize the connections to the network via the bootstrap nodes available on the `BETANET`.

### Creating a Radix Identity

Next, we need to generate a `RadixIdentity` which will handle the private/public key logic on behalf of the ChatBot. We do it by calling the `SimpleRadixIdentity()` constructor:

```java
public class ChatBot {
    static {
        RadixUniverse.bootstrap(Bootstrap.BETANET);
    }

    public ChatBot() throws IOException {
        // Load Identity
        final RadixIdentity chatBotIdentity = new SimpleRadixIdentity("chatbot.key");
    }
}
```

{% hint style="info" %}
**Note:** the`chatbot.key` file is where the private key will be saved and loaded.
{% endhint %}

### Creating a Radix Address

Now, using the public key of the identity, we can generate a unique Radix [address](https://github.com/radixdlt/radixdlt-java-docs/tree/a4d56556f33e1b032300053d7d2d93e551dab2e6/learn/glossary.md#address), which is the ChatBot's unique identifier in the Radix Universe.

```java
public class ChatBot {
    static {
        RadixUniverse.bootstrap(Bootstrap.BETANET);
    }

    private final RadixAddress address;

    public ChatBot() throws IOException {
        // Load Identity
        final RadixIdentity chatBotIdentity = new SimpleRadixIdentity("chatbot.key");
        final ECPublicKey publicKey = chatBotIdentity.getPublicKey();
        this.address = RadixUniverse.getInstance().getAddressFrom(publicKey);
    }
}
```

### Receiving messages

Once we have created an address for the ChatBot, we can begin to receive messages. To get a message we need to:

* Initialize Radix Messaging module
* Subscribe a listener to our address
* Decrypt each message \(using our identity\)
* Print every message we receive

```java
public class ChatBot {
    static {
        RadixUniverse.bootstrap(Bootstrap.BETANET);
    }

    private final RadixAddress address;

    public ChatBot() throws IOException {
        // Load Identity
        final RadixIdentity chatBotIdentity = new SimpleRadixIdentity("chatbot.key");
        final ECPublicKey publicKey = chatBotIdentity.getPublicKey();
        this.address = RadixUniverse.getInstance().getAddressFrom(publicKey);

        // Subscribe/Decrypt messages
        final Observable<RadixMessage> messageObservables = RadixMessaging.getInstance()
            .getAllMessagesDecrypted(chatBotIdentity);

        // Print messages
        messageObservables.subscribe(System.out::println);
    }
}
```

### Sending messages

Now that the ChatBot can receive messages, we can make the bot reply by sending a message back to the sender. We do this by:

* Subscribing another listener to our address
* Filtering messages \(so we don't respond to our own messages\)
* Creating and sending an encrypted echo message to the original sender

```java
public class ChatBot {
    static {
        RadixUniverse.bootstrap(Bootstrap.ALPHANET);
    }

    private final RadixAddress address;

    public ChatBot(Function<String,String> chatBotAlgorithm) {
        // Load Identity
        final RadixIdentity chatBotIdentity = new SimpleRadixIdentity("chatbot.key");
        final ECPublicKey publicKey = chatBotIdentity.getPublicKey();
        this.address = RadixUniverse.getInstance().getAddressFrom(publicKey);

        // Subscribe/Decrypt messages
        final Observable<RadixMessage> messageObservables = RadixMessaging.getInstance()
                                                                    .getAllMessagesDecrypted(chatBotIdentity);

        // Print messages
        messageObservables.subscribe(System.out::println);

        // Chatbot replies
        messageObservables
            .filter(message -> !message.getFrom().equals(address)) // Don't reply to ourselves!
            .filter(message -> Math.abs(message.getTimestamp() - System.currentTimeMillis()) < 60000) // Only reply to recent messages
            .subscribe(message ->
                RadixMessaging.getInstance()
                    .sendMessage(chatBotAlgorithm.apply(message.getContent()), chatBotIdentity, message.getFrom());
    }
}
```

### Finishing touches

At this point, we have all the basic building blocks for our simple ChatBot DApp. Now, to have a complete and functional DApp, let's add some finishing touches:

* Use a `Function<String,String>` to represent the ChatBot algorithm to make it easily extensible
* Build a `main` method to run and test by sending a message to its address

```java
import com.radixdlt.client.core.Bootstrap;
import com.radixdlt.client.core.RadixUniverse;
import com.radixdlt.client.core.address.RadixAddress;
import com.radixdlt.client.core.crypto.ECPublicKey;
import com.radixdlt.client.core.identity.OneTimeUseIdentity;
import com.radixdlt.client.core.identity.RadixIdentity;
import com.radixdlt.client.core.identity.SimpleRadixIdentity;
import com.radixdlt.client.core.network.AtomSubmissionUpdate;
import com.radixdlt.client.messaging.RadixMessage;
import com.radixdlt.client.messaging.RadixMessaging;
import io.reactivex.Observable;
import io.reactivex.ObservableSource;
import java.util.function.Function;

public class ChatBot {
    static {
        RadixUniverse.bootstrap(Bootstrap.BETANET);
    }

    private final RadixAddress address;

    public ChatBot(Function<String,String> chatBotAlgorithm) throws Exception {
        // Load Identity
        final RadixIdentity chatBotIdentity = new SimpleRadixIdentity("chatbot.key");
        final ECPublicKey publicKey = chatBotIdentity.getPublicKey();
        this.address = RadixUniverse.getInstance().getAddressFrom(publicKey);

        // Subscribe/Decrypt messages
        final Observable<RadixMessage> messageObservables = RadixMessaging.getInstance()
            .getAllMessagesDecrypted(chatBotIdentity);

        // Print messages
        messageObservables.subscribe(System.out::println);

        // Chatbot replies
        messageObservables
            .filter(message -> !message.getFrom().equals(address)) // Don't reply to ourselves!
            .filter(message -> Math.abs(message.getTimestamp() - System.currentTimeMillis()) < 60000) // Only reply to recent messages
            .flatMap((io.reactivex.functions.Function<RadixMessage, ObservableSource<AtomSubmissionUpdate>>) message ->
                RadixMessaging.getInstance().sendMessage(chatBotAlgorithm.apply(message.getContent() + " from Bot!"), chatBotIdentity, message.getFrom())
            ).subscribe(System.out::println, Throwable::printStackTrace);
    }

    public static void main(String[] args) throws Exception {
        ChatBot chatBot = new ChatBot(Function.identity());
        System.out.println("Chatbot address: " + chatBot.address);

        // Send message to bot
        RadixIdentity oneTimeUseIdentity = new OneTimeUseIdentity();
        RadixMessaging.getInstance()
            .sendMessage("Hello World", oneTimeUseIdentity, chatBot.address)
            .subscribe(System.out::println);
    }
}
```

Running this will produce output similar to this:

```text
Chatbot address: JGX2vijpLPBqTbtbznT81MGM7vVSDNDT95xHuChVdHnGzk9vBie
JGePib7zXBWa4ExNkpCmMbfkNy8H6UP351gMsdoYMgsrGUC43aB -> JGX2vijpLPBqTbtbznT81MGM7vVSDNDT95xHuChVdHnGzk9vBie: Hello World
JGX2vijpLPBqTbtbznT81MGM7vVSDNDT95xHuChVdHnGzk9vBie -> JGePib7zXBWa4ExNkpCmMbfkNy8H6UP351gMsdoYMgsrGUC43aB: Hello World from Bot!
```

Congratulations! You have now created a ChatBot connected to the Radix Network.

## Beyond the basics

As we reach the end of our DApp example, we want to share some extra code snippets for those who want to go beyond the basics and showcase a few additional things that you can do with our library.

### Code examples

* [General use](../examples/code-examples/general-use.md)
* [Atom management]()
* [Identity management](../examples/code-examples/identity-management.md)
* [Transaction management](../examples/code-examples/transaction-management.md)
* [Token management](../examples/code-examples/token-management.md)

