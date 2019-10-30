# Java style guidelines

## Introduction

This article presents the Java coding guidelines used in Radix's projects. Following these guidelines helps to ensure that Java classes are documented sufficiently and consistently.

## Code style

### Opening braces on the same line

Braces follow the Kernighan and Ritchie \(K&R\) style for nonempty blocks and block-like constructs:

* No line break before the opening brace.
* Line break after the opening brace.
* Line break before the closing brace.
* Line break after the closing brace, only if that brace terminates a statement or terminates the body of a method, constructor, or named class. For example, there is no line break after the brace if it is followed by else or a comma.

Example:

```java
/**
* A sample source file with preferred formatting
*/
 
package mypackage;
 
public class MyClass extends MyOtherClass {
    private final IntSupplier randomSupplier = () -> {
        Random r = new Random();
        return r.nextInt();
    };
 
    @Override
    public void processThing(Thing theThing) {
        if (conditionOf(theThing) == GOOD) {
            try {
                doSomethingWith(theThing);
            } catch (ProblemWithThingException e) {
                recoverFromException();
            }
        } else if (otherCondition(theThing)) {
            doSomethingElseWithThing(theThing);
        } else {
            ignoreThing(theThing);
        }
    }
}
```

### Braces Always Required

Braces are always required with `if`, `else`, `for`, `do` and `while` statements, even when the body of the statement is empty or contains only a single statement.

### Use of `this.` for Field Access

Use of the "`this`" keyword is preferred in situations where there may be ambiguity in field and variable names, such as in setters and constructors.

Example:

```java
void setFoo(FooType foo) {
    this.foo = foo; // Preferred
}
 
void setBar(BarType aBar) {
    bar = aBar; // Awkward, non-preferred
}
```

## Javadoc <a id="JavaStyleGuidelines-JavadocLocations"></a>

Properly formatted and complete Javadoc must be included for all fields and methods with either public or protected visibility.

{% hint style="info" %}
**Note:** overridden instance methods or implemented interface methods need not have Javadoc if the inherited Javadoc is correct and suitable.  In particular methods that override superclass methods and change the behaviour of the method should document the new behaviour.
{% endhint %}

### Class Comments

The following information should be present in the following order in the class comment \(`public` or `protected` classes\):

* Initial class description \(paragraph/sentence\) \(**required**\)
  * \(**required**\) **First sentence** - Should describe the class clearly and concisely. It should start with a verb \(ex: "Provides the interface for ..."\) and end with a full stop.
  * \(optional\) **Followup sentences** - Support the first sentence with important points about the class. Note, these sentences show up in the description for the class but do not show up in the summary table for the class.

Additional information if applicable:

* \(optional\) Detailed class description \(additional paragraph\(s\)\)
  * Provide more information on the class's purpose, abilities, and general role. For some classes \(simple utility classes for instance\) this additional information is not necessary if the initial paragraph provides an adequate description.
  * Usage examples or `@link` tags to where the class can be seen in use.
* `@param` tags for a class or interface's generic type parameters.
* `@see` tags to other closely related classes whose Javadocs gives the reader a clearer picture of the purpose of this class.
* `@since` tags. \(as applicable\)
* `@deprecated` tags. \(as applicable\)

Example \(class comment\):

```java
/**
 * Represents an example class. If a basic description requires more than one
 * sentence, include it in the first paragraph.
 *
 * <p>
 * Example of a second paragraph. Note the blank line between the first <p> tag
 * and the end of the first paragraph.
 * </p>
 *
 * @see    BigExample
 */
public class Example {
    ...
}
```

Example \(interface comment\):

```java
/**
 * Represents an example interface. If a basic description requires more than one
 * sentence, include it in the first paragraph.
 *
 * @param <T> the model's type
 */
public interface BinaryFunction<T> extends Function<T, BinaryFile> {
    ...
}
```

### Method Comments

The following information should be present in the Javadoc comment on each `public` or `protected` method:

* \(**required**\) A short, one sentence description of the method. It should start with a verb \(ex: "Calculates the ratio..."\) and end with a full stop.

Additional information if applicable:

* \(optional\) Additional sentences and/or paragraphs providing more information on the method's purpose and function. Any information the user of the method would find useful should be included here, including special requirements, circumstances where it should/should not be used, etc. For many methods, this additional explanation is not necessary, particularly for getters and setters.
* \(optional\) Usage examples if necessary and possible. Trivial methods don't need examples, and if an example would be extremely large, simply `@link` to a place the method is used.
* \(optional\) If the method is only used in one or two places, `@link` to the methods it is called from. This helps later developers to understand its role in Radix.

The following information should **always** be present in the following order in the Javadoc tags for the method:

* `@param` - The method parameters, in order, with descriptions.
* `@return` - All possible return values, including null. If the method is void, do not include this.
* `@throws` - The checked exceptions the method can throw, in order, with explanations of what would trigger them.

Additional information if applicable:

* `@see` - \(as applicable\)
* `@since` - \(as applicable\)
* `@deprecated` - \(as applicable\)

Example \(method comments\):

```java
/**
 * Returns the localized preferences values for the key, optionally using the
 * default language if the no localization exists for the requested
 * language.
 *
 * @param  preferences the preferences container
 * @param  key the preferences key
 * @param  languageId the primary key of the language
 * @param  useDefault whether to use the default language if no localization
 *         exists for the requested language
 * @return the localized preferences values. If <code>useDefault</code> is
 *         <code>false</code> and no localization exists for the requested
 *         language, an empty array will be returned.
 * @throws PortalException if a portal exception occurred
 */
public String[] getPreferencesValues(
        PortletPreferences preferences, String key, String languageId,
        boolean useDefault);
    throws PortalException;
```

### Method comments for interfaces and sub-classes <a id="Javadocguidelines-Methodcommentsforinterfacesandsub-classes"></a>

* **Interface method Javadoc** is _always_ required.
* **Sub-class Method Javadoc** is required for methods of sub-classes that have differences from their parent class\(es\) that should be noted. Some examples are sub-class methods that have different behavior, different side-effects, and/or different requirements of their parameters. For overridden methods without any Javadoc, the Javadoc is directly inherited from the superclass.If you need to add to the superclass' Javadoc, then `{@inheritDoc}` should be used inside the Javadoc comment, followed by any additional information.

### Recommendations

* If you're new to Javadoc, familiarize yourself with the [official Javadoc style guide](http://www.oracle.com/technetwork/java/javase/documentation/index-137868.html). If you're experienced with Javadoc, you can check the [Advanced Javadoc guide](https://github.com/liferay/liferay-portal/blob/master/readme/ADVANCED_JAVADOC_GUIDELINES.markdown).
* Starting with an action word, describe what each class and method does.
* Avoid just restating the class or method name \(e.g., Avoid "updateLocalization\(...\) → Updates the localization" or "`@param` key the key"\).
* Describe the most important details in the first sentence, because it is the only one shown in the class/method summary.
* Include all relevant tags \(`@param`, `@return`, etc\) for each method; without them, the method Javadoc is incomplete.
* Start a method description with Returns, if the method returns a value.
* Don’t explicitly refer to collections in descriptions \(e.g., list of articles\). Use, instead, the plural \(e.g., the articles\) or “all the” \(e.g., all the articles\).
* When referring to another class, try to either link using {`@link entity`} \(e.g., {`@link network.impl.advertisement.ItemAdvertisement`}\) or refer to the class in common terms \(e.g., item advertisement\). The first alternative provides direct access to the class's Javadoc, the second alternative makes for smooth reading.
* Avoid referring explicitly to parameters by name; instead, refer to them in general terms \(e.g., class name ID instead of `classNameId`\).
* Refer to primary keys explicitly, even when the parameter is an ID. For example, use _"the primary key of the something"_ instead of _"the ID of the something"_.
* Begin boolean parameter descriptions with whether \(ex: _"whether to initialize the node"_\).
* Punctuate every class and method description \(sentence or phrase\) with a period.
* Only punctuate an initial description \(sentence or phrase\) for a method tag `@param`, `@return`, or `@throws` if it's followed by a sentence\(s\). Write followup text in complete sentences.
* Describe exceptions \(e.g., `@throws`\) in past tense.
* Only include a class's package in an `@see` and `@link` tag if the class is in another package. Refer to the [Advanced Javadoc guidelines](https://github.com/liferay/liferay-portal/blob/master/readme/ADVANCED_JAVADOC_GUIDELINES.markdown#javadoc-linking) page for comprehensive rules and examples on linking to other methods/classes.
* Don't wrap the first paragraph of a Javadoc comment with paragraph tags. Do wrap subsequent paragraphs with paragraph tags \(e.g., `<p>second paragraph</p>`\).
* Conform Javadoc to 80 columns, if possible.

