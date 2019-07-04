# Creating an ERC-like token

## Introduction

In this tutorial, we will build an ERC-like token.

## Creating a Radix Identity

The first step is to create an identity based on public/private keys.

```java
public class CreateToken {
  public static void main(String[] args) {
    RadixIdentity identity = RadixIdentities.loadOrCreateEncryptedFile("my.key", "password123");
  }
}
```

## Initializing the API

Next, we initialize the API by using our identity and selecting to bootstrap into the BETANET network.

```java
public class CreateToken {
  public static void main(String[] args) {
    RadixIdentity identity = RadixIdentities.loadOrCreateEncryptedFile("my.key", "password123");
    RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.BETANET, identity);
  }
}
```

## Creating an RRI

Every resource on the Radix Ledger is globally identified by a unique RRI. In our case, the token we will create will have an RRI of `/<address>/TOKEN`.

```java
public class CreateToken {
  public static void main(String[] args) {
    RadixIdentity identity = RadixIdentities.loadOrCreateEncryptedFile("my.key", "password123");
    RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.BETANET, identity);
    RRI tokenRRI = RRI.of(api.getAddress(), "TOKEN");
  }
}
```

## Creating and Minting a Token On Ledger

With the RRI we can now create and mint the token on ledger.

```java
public class CreateToken {
  public static void main(String[] args) {
    RadixIdentity identity = RadixIdentities.loadOrCreateEncryptedFile("my.key", "password123");
    RadixApplicationAPI api = RadixApplicationAPI.create(Bootstrap.BETANET, identity);
    RRI tokenRRI = RRI.of(api.getAddress(), "TOKEN");
    api.createMultiIssuanceToken(tokenRRI, "Cool Token", "The Best Token!").blockUntilComplete();
    api.mintTokens(tokenRRI, BigDecimal.valueOf(1000000.00)).blockUntilComplete();
  }
}
```

## Sending Tokens

Congratulations you now have tokens on ledger! You can now send your tokens to any other address:

```java
api.sendTokens(tokenRRI, <to-address>, BigDecimal.valueOf(10.99)).blockUntilComplete();
```

