//
//  ObjectiveGumbo.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OGElement.h"
#import "OGNode.h"
#import "OGDocument.h"
#import "OGText.h"
#import "OGNode+OGElementSearch.h"
#import "OGError.h"

@interface ObjectiveGumbo : NSObject

+ (nullable OGDocument *)documentWithData:(NSData *)data
                                 encoding:(NSStringEncoding)enc
                                    error:(NSError **)error;

+ (nullable OGDocument *)documentWithString:(NSString *)string
                                      error:(NSError **)error;

+ (nullable OGDocument *)documentWithURL:(NSURL *)url
                                encoding:(NSStringEncoding)enc
                                   error:(NSError **)error;


+ (nullable OGNode *)nodeWithData:(NSData *)data
                         encoding:(NSStringEncoding)enc
                            error:(NSError **)error;

+ (nullable OGNode *)nodeWithString:(NSString *)string
                              error:(NSError **)error;

+ (nullable OGNode *)nodeWithURL:(NSURL *)url
                        encoding:(NSStringEncoding)enc
                           error:(NSError **)error;
@end
