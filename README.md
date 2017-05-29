# ObjectiveGumbo

ObjectiveGumbo is a library that makes it easier and safer to interact with the data inside HTML content. Rather than use Regex to extract some data, ObjectiveGumbo uses Gumbo - Google's fast HTML5 parsing library (written in C). Gumbo mimics how a browser parses HTML including when tags are missing or the HTML is not properly formed. ObjectiveGumbo full abstracts aways the C Gumbo data-structures to provide an easy-to-understand interface for use in Objective-C and Swift. 

## Compilation
The current recommended method for adding ObjectiveGumbo to your iOS project (currently not supported for OSX) is to install it via [CocoaPods](http://cocoapods.org/). You can do that by adding the following to your Podfile and running `pod install`:

	platform :ios, '9.0'
	pod "ObjectiveGumbo", :git => 'https://github.com/rwarrender/ObjectiveGumbo.git'

When you want to use ObjectiveGumbo in your project, simply import the header:

```obj-c
#import <ObjectiveGumbo.h>
```

If you'd like to use ObjectiveGumbo with Swift, you'll need to add a bridging header to your project and import as above. You can then use ObjectiveGumbo as normal.


## Example usage

Fetch all of the links from the [Hacker News](http://news.ycombinator.com) homepage and log them (see the Hacker News example for a more advanced method):

Objective-C
```obj-c
OGNode *data = [ObjectiveGumbo nodeWithURL:[NSURL URLWithString:@"https://news.ycombinator.com"]
                                  encoding:NSUTF8StringEncoding
                                     error:nil];
NSArray *tableRows = [data elementsWithClass:@"title"];
for (OGElement *tableRow in tableRows)
{
	if (tableRow.children.count > 1)
	{
		OGElement *link = tableRow.children[0];
		NSLog(@"%@", link.attributes[@"href"]);
	}
}
```

Swift
```swift
let data = try! ObjectiveGumbo.document(with: URL(string:"https://news.ycombinator.com")!,
                                        encoding: String.Encoding.utf8.rawValue)
let tableRows = data.elements(withClass: "title")
for tableRow in tableRows {
    if (tableRow.children.count > 1),
        let link = tableRow.children.first as? OGElement,
        let href = link.attributes["href"] {
        print(href)
    }
}
```

Get the body text of BBC News:

Objective-C
```obj-c
OGNode *doc = [ObjectiveGumbo documentWithURL:[NSURL URLWithString:@"http://bbc.co.uk/news"]
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
OGElement *body = doc.body;
NSLog(@"%@", body.text);
```

Swift
```swift
let doc = try! ObjectiveGumbo.document(with: URL(string:"http://bbc.co.uk/news")!,
                                        encoding: String.Encoding.utf8.rawValue)
if let body = doc.body {
    print(body.text)
}
```


Use basic CSS selectors to extract elements

Objective-C
```obj-c
OGNode *doc = [ObjectiveGumbo documentWithURL:[NSURL URLWithString:@"https://www.reddit.com/"]
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
NSArray *storyLinks = doc[@".entry a.title"];

for (OGElement *link in storyLinks) {
    NSLog(@"Link Text: %@", link.attributes[@"href"]);
}
```

Swift
```swift
let doc = try! ObjectiveGumbo.document(with: URL(string:"https://www.reddit.com/")!,
                                        encoding: String.Encoding.utf8.rawValue)
let storyLinks = doc[".entry a.title"] as! [OGElement]
for link in storyLinks {
    if let linkText = link.attributes["href"] {
        print("Link Text: \(linkText)")
    }
}
```

Extract Facebook Open Graph Tags

Objective-C
```obj-c
OGNode *doc = [ObjectiveGumbo documentWithURL:[NSURL URLWithString:@"https://www.facebook.com/"]
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
OGElement *imageElement = [doc firstElementForRDFaProperty:@"og:image"];
NSLog(@"Image URL: %@", imageElement.attributes[@"content"]);
```

Swift
```swift
let doc = try! ObjectiveGumbo.document(with: URL(string:"https://www.facebook.com/")!,
                                        encoding: String.Encoding.utf8.rawValue)
let imageElement = doc.firstElement(forRDFaProperty: "og:image")!
let imageURLString = imageElement.attributes["content"] as! String
print("Image URL: \(imageURLString)")
```


## Why use this over the plain C API?
This has been written with object-orientation and Cocoa in mind to make it a lot easier to interact with from Objective-C, which also gains the benefits of not having to worry about C-style pointers and releasing memory. Furthermore, it also uses 'native' Objective-C paradigms such as dictionaries and arrays rather than the Vector implementation provided Gumbo. It also reduces the amount of code you have to write by allowing you to quickly fetch tags based on tag, ID or class (like jQuery). 

## Classes
### ObjectiveGumbo
This class should be used for parsing HTML from NSStrings, NSURLs or NSData. Please note that, like Gumbo, ObjectiveGumbo *only* supports UTF8 web pages.

### OGNode
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

### OGElement
A subclass of OGNode that provides an array of child elements, a dictionary of attributes and an array of classes.

### OGDocument
A subclass of OGElement that includes DOCTYPE information.

### OGText
A subclass of OGNode that represents some plain text. Note that all OGNodes have a -(NSString*)text function, however OGElement recursively searches its children.

## Future aims

* Progress in line with Gumbo
* Once Gumbo reaches final release port the majority of the code over to Objective-C or rewrite non-trivial parts using Cocoa classes (NSString, NSArray, NSDictionary, etc)
* Add more jQuery like selection features

## Contact
If you are using ObjectiveGumbo in your projects or want to ask specific support questions feel free to email at programmingthomas [at] gmail [dot] com. Submitting issues is an equally good way to reach me
