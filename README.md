#ObjectiveGumbo

ObjectiveGumbo is a set of classes that make it easier to interact with Gumbo, Google's HTML5 parsing library (written in C), from Objective-C.

##Examples

Two examples are packaged with ObjectiveGumbo, one for Mac and one for iOS. The Mac project is a simple example of how you can parse HTML from Gumbo, recursively search through the structure and then output Markdown. This doesn't support the full Markdown spec (literally just bold, italics and links) as it is just a simple demo. The iOS demo shows how to fetch the main Hacker News page, parse the HTML, find the article names/links and finally present this list in a table view. Again, this is just a simple demo and not a full fledged client!

##Compilation
To add ObjectiveGumbo to your Mac/iOS project do the following:

* Get a local copy of this repository and [Gumbo](http://github.com/google/gumbo-parser)
* Add the ObjectiveGumbo directory to your Xcode project and ensure that Xcode is set to build all the .m source files - I recommend you do not copy to the project directory
* Follow the instructions for building Gumbo from Google's guide
* Add the src folder from Gumbo to your project (excluding any files that are not C source files or headers) - I recommend you do not copy to the project directory
* Ensure Xcode is set to build all of the C files in the src directory
* Import "ObjectiveGumbo.h" in your Objective-C files
* Note that I am 'using' ARC (it's 2013, there isn't really any reason not to use ARC in new projects)

I am currently not particularly pleased with the way that you have to build the project and I hope to find a more sensible way of doing this soon.

##Example usage

	OGNode * data = [ObjectiveGumbo parseDocumentWithUrl:[NSURL urlWithString:@"http://news.ycombinator.com"]];
	NSLog(@"%@", data.text);
	NSArray * tableRows = [data elementsWithClass:@"title"];
	for (OGElement * tableRow in tableRows)
	{
		if (tableRow.children.count > 1)
		{
			OGElement * link = tableRow.children[0];
			NSLog(@"%@", link.attributes[@"href"]);
		}
	}

##Why use this over the plain C API?
This has been written with object-orientation and Cocoa in mind to make it a lot easier to interact with from Objective-C, which also gains the benefits of not having to worry about C-style pointers and releasing memory. Furthermore, it also uses 'native' Objective-C paradigms such as dictionaries and arrays rather than the Vector implementation provided Gumbo. It also reduces the amount of code you have to write by allowing you to quickly fetch tags based on tag, ID or class (like jQuery). 

##Future aims

* Progress in line with Gumbo
* Once Gumbo reaches final release port the majority of the code over to Objective-C or rewrite non-trivial parts using Cocoa classes (NSString, NSArray, NSDictionary, etc)
* Add more jQuery like selection features