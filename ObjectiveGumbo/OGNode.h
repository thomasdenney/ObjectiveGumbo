//
//  OGNode.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gumbo.h"
#import "OGUtility.h"
#import "NSString+OGString.h"

@interface OGNode : NSObject

@property OGNode * parent;

-(NSString*)text;
-(NSString*)html;

//Usage:
//#stuffwiththisid .orthisclass orthistag
-(NSArray*)select:(NSString*)selector;

-(NSArray*)elementsWithClass:(NSString*)class;
-(NSArray*)elementsWithID:(NSString*)id;
-(NSArray*)elementsWithTag:(GumboTag)tag;

@end
