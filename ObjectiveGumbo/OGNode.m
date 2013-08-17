//
//  OGNode.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"

@implementation OGNode

-(NSString*)text
{
    return @"";
}

-(NSArray*)elementsWithClass:(NSString*)class
{
    return [NSArray new];
}

-(NSArray*)elementsWithID:(NSString *)id
{
    return [NSArray new];
}

-(NSArray*)elementsWithTag:(GumboTag)tag
{
    return [NSArray new];
}

@end
