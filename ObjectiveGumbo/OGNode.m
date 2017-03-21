//
//  OGNode.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"

@interface OGNode ()

@property (nonatomic, strong) NSString *text;

@end


@implementation OGNode

-(NSString*)text
{
    return @"";
}

-(NSString*)html
{
    return [self htmlWithIndentation:0];
}

-(NSString*)htmlWithIndentation:(int)indentationLevel
{
    return @"";
}

- (OGNode *)first
{
    return [self.children firstObject];
}

- (OGNode *)last
{
    return [self.children lastObject];
}



@end
