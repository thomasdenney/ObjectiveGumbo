//
//  ObjectiveGumbo.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OGTags.h"
#import "OGElement.h"
#import "OGNode.h"
#import "OGNode+OGElementSearch.h"
#import "OGDocument.h"
#import "OGText.h"
#import "OGError.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @brief This class is used to parse HTML strings, data or URLs into OGNode trees that resemble HTML pages using the HTML Document Object Model.
 
 @discussion This is a data model layer only and can be used to write validators, parsers, linters and other really useful tools.

 If you're parsing a full HTML document, you should use the document-prefixed class methods. However if you're working on snippets use the node-prefixed class methods. Note however that using the node-prefixed class methods will result in @b ownerDocument property on nodes being nil.
 */
@interface ObjectiveGumbo : NSObject

/** Parse HTML data and return an OGDocument node. */
+ (nullable OGDocument *)documentWithData:(NSData *)data
                                 encoding:(NSStringEncoding)enc
                                    error:(NSError **)error;

/** Parse an HTML string and return an OGDocument node. */
+ (nullable OGDocument *)documentWithString:(NSString *)string
                                      error:(NSError **)error;

/** Download, parse and return an OGDocument node. */
+ (nullable OGDocument *)documentWithURL:(NSURL *)url
                                encoding:(NSStringEncoding)enc
                                   error:(NSError **)error;


/** Parse HTML data and return an OGNode node. */
+ (nullable OGNode *)nodeWithData:(NSData *)data
                         encoding:(NSStringEncoding)enc
                            error:(NSError **)error;

/** Parse an HTML string and return an OGNode node. */
+ (nullable OGNode *)nodeWithString:(NSString *)string
                              error:(NSError **)error;

/** Download, parse and return an OGNode node. */
+ (nullable OGNode *)nodeWithURL:(NSURL *)url
                        encoding:(NSStringEncoding)enc
                           error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
