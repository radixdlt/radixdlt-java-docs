# Enabling debug logging

## Introduction

While developing a software application, having a simple way to enable logging for debugging purposes is often required. In this short article, we explain how to set up and activate the built-in [SLF4J](https://www.slf4j.org/) \(Simple Logging Facade for Java\) module in the Radix Java client library.

## Enabling logging

To enable the SLF4J logging module, you need to create a `simplelogger.properties` file into the following `radixdlt-java` library path: 

```text
src/main/resources/simplelogger.properties
```

In the new `simplelogger.properties` file you need to add at least one line with the desired log level, e.g.:

```perl
# My SLF4J configuration
# Must be one of ("trace", "debug", "info", "warn", or "error")
org.slf4j.simpleLogger.defaultLogLevel=error
```

## Additional settings

For quick reference, here's a table with additional settings and their possible values:

| Property | Values |
| :--- | :--- |
| org.slf4j.simpleLogger.defaultLogLevel | trace, debug, info, warn, error |
| org.slf4j.simpleLogger.showDateTime | true, false |
| org.slf4j.simpleLogger.dateTimeFormat | string \(Simple Date Format\) |
| org.slf4j.simpleLogger.showThreadName | true, false |
| org.slf4j.simpleLogger.showLogName | true, false |
| org.slf4j.simpleLogger.showShortLogName | true, false |

{% hint style="info" %}
**Note:** please refer to the [SLF4J documentation](https://www.slf4j.org/api/org/slf4j/impl/SimpleLogger.html) for further options and detailed information.
{% endhint %}

## Sample simplelogger.properties

For your convinience, we include a sample `simplelogger.properties` file with extensive debug logging enabled:

{% code-tabs %}
{% code-tabs-item title="simplelogger.properties" %}
```perl
# SLF4J's SimpleLogger configuration file
# Simple implementation of Logger that sends all enabled log messages, for all defined loggers, to System.err.

# Default logging detail level for all instances of SimpleLogger.
# Must be one of ("trace", "debug", "info", "warn", or "error").
# If not specified, defaults to "info".
org.slf4j.simpleLogger.defaultLogLevel=debug

# Set to true if you want the current date and time to be included in output messages.
# Default is false, and will output the number of milliseconds elapsed since startup.
org.slf4j.simpleLogger.showDateTime=true

# The date and time format to be used in the output messages.
# The pattern describing the date and time format is the same that is used in java.text.SimpleDateFormat.
# If the format is not specified or is invalid, the default format is used.
# The default format is yyyy-MM-dd HH:mm:ss:SSS Z.
org.slf4j.simpleLogger.dateTimeFormat=yyyyMMdd HH:mm:ss.SSS Z

# Set to true if you want to output the current thread name.
# Defaults to true.
org.slf4j.simpleLogger.showThreadName=true

# Set to true if you want the Logger instance name to be included in output messages.
# Defaults to true.
org.slf4j.simpleLogger.showLogName=true

# Set to true if you want the last component of the name to be included in output messages.
# Defaults to false.
org.slf4j.simpleLogger.showShortLogName=true
```
{% endcode-tabs-item %}
{% endcode-tabs %}

