#ObjectiveGumbo

ObjectiveGumbo is a set of classes that make it easier to interact with Gumbo, Google's HTML5 parsing library (written in C), from Objective-C.

##Examples

Examples were originally packaged with ObjectiveGumbo, however in order to avoid it getting bloated I've moved them into a separate repository. For examples for iOS and OSX please now go to my [OG-Demos repository](https://github.com/programmingthomas/OG-Demos).

##Compilation
The current recommended method for adding ObjectiveGumbo to your iOS project (currently not supported for OSX) is to install it via [CocoaPods](http://cocoapods.org/). You can do that by adding the following to your Podfile and running `pod install`:

	platform :ios, '6.0'
	pod "ObjectiveGumbo", "0.1"

Alternatively if you are working with OSX or don't wish to use CocoaPods, you can do the following:

* Get a local copy of this repository
* Add the ObjectiveGumbo directory to your Xcode project or alternatively add your project to the ObjectiveGumbo workspace. This directory also contains the source code for Gumbo

When you want to use ObjectiveGumbo in your project, simply import the header:

```obj-c
#import <ObjectiveGumbo.h>
```

##Example usage

Fetch all of the links from the [Hacker News](http://news.ycombinator.com) homepage and log them (see the Hacker News example for a more advanced method):
```obj-c
OGNode * data = [ObjectiveGumbo parseDocumentWithUrl:[NSURL URLWithString:@"http://news.ycombinator.com"]];
NSArray * tableRows = [data elementsWithClass:@"title"];
for (OGElement * tableRow in tableRows)
{
	if (tableRow.children.count > 1)
	{
		OGElement * link = tableRow.children[0];
		NSLog(@"%@", link.attributes[@"href"]);
	}
}
```

Get the body text of BBC News:
```obj-c
OGNode * data = [ObjectiveGumbo parseDocumentWithUrl:[NSURL URLWithString:@"http://bbc.co.uk/news"]];
OGElemet * body = [data elementsWithTag:GUMBO_TAG_BODY];
NSLog(@"%@", body.text);
```

##Why use this over the plain C API?
This has been written with object-orientation and Cocoa in mind to make it a lot easier to interact with from Objective-C, which also gains the benefits of not having to worry about C-style pointers and releasing memory. Furthermore, it also uses 'native' Objective-C paradigms such as dictionaries and arrays rather than the Vector implementation provided Gumbo. It also reduces the amount of code you have to write by allowing you to quickly fetch tags based on tag, ID or class (like jQuery). 

##Classes
###ObjectiveGumbo
This class should be used for parsing HTML from NSStrings, NSURLs or NSData. Please note that, like Gumbo, ObjectiveGumbo *only* supports UTF8 web pages.

###OGNode
All tags and pieces of text get converted to an OGNode (and its subclasses). So the following HTML would be parsed as follows:

	<p>This is a paragraph. <b>This is bold</b></p>
	Paragraph (OGElement)
		'This is a paragraph. ' (OGText)
		Bold (OGElement)
			'This is bold'	

OGNode provides a variety of utility functions such as fetching the plaintext content and finding child nodes quickly:

* elementsWithClass allows you to quickly find all elements with the given class
* elementsWithID returns an array of all elements with a matching ID
* elementsWithTag finds all tags of a certain type (such as links)

###OGElement
A subclass of OGNode that provides an array of child elements, a dictionary of attributes and an array of classes.

###OGDocument
A subclass of OGElement that includes DOCTYPE information. If you use the parseDocument* functions in ObjectiveGumbo you will receive this back as the root element.

###OGText
A subclass of OGNode that represents some plain text. Note that all OGNodes have a -(NSString*)text function, however OGElement recursively searches its children.

##Future aims

* Progress in line with Gumbo
* Once Gumbo reaches final release port the majority of the code over to Objective-C or rewrite non-trivial parts using Cocoa classes (NSString, NSArray, NSDictionary, etc)
* Add more jQuery like selection features

##Contact
If you are using ObjectiveGumbo in your projects or want to ask specific support questions feel free to email at programmingthomas [at] gmail [dot] com. Submitting issues is an equally good way to reach me
