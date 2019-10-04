# Message management

## Introduction

Let's review some code examples on how to handle messages with the Java client library:

* [Sending messages](message-management.md#sending-messages)
* [Receiving messages](message-management.md#receiving-messages)
* [Messaging example](message-management.md#messaging-example)

{% hint style="success" %}
**Tip:** if you're new to our Java library, we suggest you begin with our [Get Started guide](../../guides/getting-started.md).
{% endhint %}

## Sending messages

Immutable data can be stored on the ledger. The data can be encrypted so that only selected identities can read the data.

To send the encrypted string `Hello` which only the sender and recipient can read:

```java
Result result = api.sendMessage(<to-address>, "Hello".getBytes(StandardCharsets.UTF_8), true);
result.blockUntilComplete();
```

To send the unencrypted string `Hello`:

```java
Result result = api.sendMessage(<to-address>, "Hello".getBytes(StandardCharsets.UTF_8), false);
result.blockUntilComplete();
```

Or equivalently,

```java
SendMessageAction msgAction = SendMessageAction.create(api.getAddress(), <to-address>, "Hello".getBytes(StandardCharset.UTF_8), false);
Result result = api.execute(msgAction);
result.blockUntilComplete();
```

## Receiving messages

To read \(and decrypt if necessary\) all the readable data at an address:

```java
Observable<DecryptedMessage> readable = api.getMessages();
readable.subscribe(data -> { ... });
```

{% hint style="info" %}
**Note:** data that can't be decrypted by the user's key is simply ignored.
{% endhint %}

## Messaging example

Based on the previous sending and receiving samples, the following code snippet presents a full messaging example.

{% hint style="info" %}
**Note:** you can get the complete sample source code from our [GitHub repository](https://github.com/radixdlt/radixdlt-java/blob/release/1.0-beta.4/examples/src/main/java/com/radixdlt/client/examples/MessagesExample.java).
{% endhint %}

```java
public class MessagesExample {
	public static void main(String[] args) {
		// Create a new public key identity
		final RadixIdentity radixIdentity = RadixIdentities.createNew();

		// Initialize api layer
		RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.LOCALHOST, radixIdentity);

		// Sync with network
		api.pull();

		System.out.println("My address: " + api.getAddress());
		System.out.println("My public key: " + api.getPublicKey());

		// Print out all past and future messages
		api.observeMessages().subscribe(System.out::println);

		// Send a message to an address
		RadixAddress toAddress = RadixAddress.from("JEbhKQzBn4qJzWJFBbaPioA2GTeaQhuUjYWkanTE6N8VvvPpvM8");
		Result result = api.sendMessage(toAddress, "Hello".getBytes(RadixConstants.STANDARD_CHARSET), true);
		result.blockUntilComplete();
	}
}
```

