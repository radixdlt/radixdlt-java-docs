---
description: >-
  The developers guide to building on the Radix Network with the Java client
  library
---

# Java client library

[![](https://jitpack.io/v/com.radixdlt/radixdlt-java.svg)](https://jitpack.io/#com.radixdlt/radixdlt-java) [![Build Status](https://travis-ci.com/radixdlt/radixdlt-java.svg?branch=master)](https://travis-ci.com/radixdlt/radixdlt-java) [![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java&metric=alert_status)](https://sonarcloud.io/dashboard?id=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java) [![Reliability](https://sonarcloud.io/api/project_badges/measure?project=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java&metric=reliability_rating)](https://sonarcloud.io/component_measures?id=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java&metric=reliability_rating) [![Security](https://sonarcloud.io/api/project_badges/measure?project=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java&metric=security_rating)](https://sonarcloud.io/component_measures?id=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java&metric=security_rating) [![Code Corevage](https://sonarcloud.io/api/project_badges/measure?project=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java&metric=coverage)](https://sonarcloud.io/component_measures?id=com.radixdlt%3Aradixdlt-java%3Aradixdlt-java&metric=Coverage) [![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/radixdlt/radixdlt-java/blob/master/LICENSE)

## Introduction  <a id="introduction"></a>

A Java client library for interacting with a [Radix](https://www.radixdlt.com/) Distributed Ledger.

{% hint style="info" %}
**Note:** this library and the network itself are currently in **Beta** development phase. Please report any issues in the [GitHub issue tracker](https://github.com/radixdlt/radixdlt-java/issues).
{% endhint %}

## Features  <a id="features"></a>

* Connect to the Betanet test network
* Fee-less transactions for test networks
* Public Key Identity Creation
* Token Creation \(ERC-777 style\)
* Message sending
* RXJava 2 based
* Utilizes JSON-RPC over WebSockets

## Gradle  <a id="gradle"></a>

Include the following Gradle dependency:

```javascript
repositories {
    maven { url 'https://jitpack.io' }
}
```

```javascript
dependencies {
    implementation 'com.radixdlt:radixdlt-java:0.12.0'
}
```

## Join the Radix Community  <a id="join-the-radix-community"></a>

* ​[Telegram](https://t.me/radix_dlt) for general chat
* ​[Discord](https://discord.gg/7Q7HSZZ) for developers chat
* ​[Reddit](https://reddit.com/r/radix) for general discussion
* ​[Forum](https://forum.radixdlt.com/) for technical discussion
* ​[Twitter](https://twitter.com/radixdlt) for announcements
* ​[Email newsletter](https://radixdlt.typeform.com/to/nyKvMV) for weekly updates
* Mail to [hello@radixdlt.com](mailto:info@radixdlt.com) for general enquiries.

