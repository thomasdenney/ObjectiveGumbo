//
//  OGNode.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gumbo.h"

@interface OGNode : NSObject

@property OGNode * parent;

-(NSString*)text;

-(NSArray*)elementsWithClass:(NSString*)class;
-(NSArray*)elementsWithID:(NSString*)id;
-(NSArray*)elementsWithTag:(GumboTag)tag;

@end
