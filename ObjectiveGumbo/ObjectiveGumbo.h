// ObjectiveGumbo.h
//
// Copyright 2014 Programming Thomas
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

@import Foundation;

#import "OGElement.h"
#import "OGNode.h"
#import "OGDocument.h"
#import "OGText.h"

/**
 Objective Gumbo allows you to easily parse HTML from Objective-C or Swift by wrapping the C API into a convenient objected-orientated API that you can easily use to query the DOM or scrape sites.
 */
@interface ObjectiveGumbo : NSObject

///----------------------
///@name Document parsing
///----------------------

/**
 Parses a document, which is some HTML that includes a DOCTYPE, that may have been loaded from a file or URL. This is the recommended method for parsing web pages.
 @param data The web page data
 @param enc The encoding type to use. Note that Gumbo only supports UTF-8 encoded web pages
 @return An OGDocument object that represents the DOM of the supplied HTML
 @see OGDocument
 */
+ (OGDocument*)parseDocumentWithData:(NSData*)data encoding:(NSStringEncoding)enc;

/**
 Parses a document, which is some HTML that includes a DOCTYPE, that may have been loaded from a file or URL.
 @note This is not the recommended method for parsing web page data. You should instead use parseDocuemntWithData:encoding: if you are downloading data from a server or loading from a file
 @param data The web page data
 @return An OGDocument object that represents the DOM of the supplied HTML
 @see OGDocument
 */
+ (OGDocument*)parseDocumentWithString:(NSString*)string;

/**
 Synchronously downloads data from a URL and parses the HTML
 @param url The url to download the data from
 @param enc The encoding of the data that will be downloaded
 @return An OGDocument object if the parsing is successful
 @note Please, please don't use this method. Seriously, don't use it. Firstly, it downloads the data synchronously. That encourages you to do it on the main thread, which is bad! Secondly, you might not know the encoding of the data you're downloading. Finally, you should be using NSURLSession or AFNetworking for serious networking code. Don't use this method.
 @see OGDocument
 */
+ (OGDocument*)parseDocumentWithUrl:(NSURL*)url encoding:(NSStringEncoding)enc __attribute__((deprecated));

///------------------
///@name Node parsing
///------------------

/**
 TODO: Support custom encoding
 Parses HTML data for individual nodes and their children (e.g. a paragraph) and produces an OGNode object.
 @param data The HTML node data to parse (e.g. `<p>This is a <em>paragraph</em></p>`)
 @return An OGNode object representing the node whose HTML source has been parsed
 @note If you are parsing a full web page you will want to use the document parsing methods rather than this method
 @see OGNode
 */
+ (OGNode*)parseNodeWithData:(NSData*)data;

/**
 Parses HTML data for individual nodes and their children (e.g. a paragraph) and produces an OGNode object.
 @param data The HTML node data to parse (e.g. `<p>This is a <em>paragraph</em></p>`)
 @return An OGNode object representing the node whose HTML source has been parsed
 @note If you are parsing a full web page you will want to use the document parsing methods rather than this method. Generally the parseNodeWithData: method is preferred.
 @see OGNode
 */
+ (OGNode*)parseNodeWithString:(NSString*)string;

@end