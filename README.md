#Objective Gumbo

Objective Gumbo is a set of classes that make it easier to interact with [Gumbo](https://github.com/google/gumbo-parser), Google's HTML5 parsing library (written in C), from Objective-C and Swift.

**Please note that you are viewing the experimental version 2 branch, which uses the same API as the original project, however has a very different project architecture.**

##Using Objective Gumbo in your projects

* Version 2 doesn't currently support CocoaPods
* Add the Objective Gumbo repository to your project by downloading the source or adding it as a git submodule
* You'll need to run `git submodule init` and `git submodule update` to ensure that both the Objective Gumbo source and the Gumbo source are pulled
* Link your app with the Objective Gumbo framework

##Examples

**TODO:** Version 2 examples.

##Why use this over the plain C API?

Objective Gumbo can be used to parse HTML from both Objective-C and Swift. It supports a jQuery style API for querying the DOM. Objective Gumbo doesn't expose any of the raw C API to you, which means that it is a lot safer and easier to use.

##Code style

Objective Gumbo is written according to the [New York Times style guide](https://github.com/NYTimes/objective-c-style-guide) and validated with [Knyt](https://github.com/programmingthomas/knyt).

##Class heirarchy

###ObjectiveGumbo

Parses HTML from `NSString`, `NSURL` or `NSData`. Like Gumbo, Objective Gumbo only supports parsing UTF-8 pages. **Is this still true?**

###OGNode

All tags and pieces of text get converted to an `OGNode` (and its subclasses). So the following HTML would be parsed as follows:

```html
	<p>This is a paragraph. <b>This is bold</b></p>
```

```
	Paragraph (OGElement)
		'This is a paragraph. ' (OGText)
		Bold (OGElement)
			'This is bold'	
```

`OGNode` provides a variety of utility functions such as fetching the plaintext content and finding child nodes quickly:

* elementsWithClass allows you to quickly find all elements with the given class
* elementsWithID returns an array of all elements with a matching ID
* elementsWithTag finds all tags of a certain type (such as links)

###OGElement

A subclass of `OGNode` that provides an array of child elements, a dictionary of attributes and an array of classes.

###OGDocument

A subclass of `OGElement` that includes DOCTYPE information. If you use the parseDocument* functions in Objective Gumbo you will receive this back as the root element.

###OGText

A subclass of `OGNode` that represents some plain text. Note that all OGNodes have a `-(NSString*)text` function, however `OGElement` recursively searches its children.

##Future aims

* Full Swift support
* Swift pattern matching for searching the DOM

##Contact

If you are using Objective Gumbo in your projects or want to ask specific support questions feel free to email at me@programmingthomas.com. Submitting issues is an equally good way to reach me
