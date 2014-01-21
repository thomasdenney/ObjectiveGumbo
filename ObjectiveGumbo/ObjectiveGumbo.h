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

@interface ObjectiveGumbo : NSObject

+(OGDocument*)parseDocumentWithData:(NSData*)data encoding:(NSStringEncoding)enc;
+(OGDocument*)parseDocumentWithString:(NSString*)string;
+(OGDocument*)parseDocumentWithUrl:(NSURL*)url encoding:(NSStringEncoding)enc;

+(OGNode*)parseNodeWithData:(NSData*)data;
+(OGNode*)parseNodeWithString:(NSString*)string;
+(OGNode*)parseNodeWithUrl:(NSURL*)url encoding:(NSStringEncoding)enc;

@end
