//
//  OGNode.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"
#import "OGNodeProtected.h"

@implementation OGNode

- (instancetype)initWithGumboNode:(GumboNode *)gumboNode
{
    if (self = [super init]) {
        // This is really an abstract class
    }
    return self;
}

- (NSString *)html
{
    return [self htmlWithIndentation:0];
}

- (NSString *)htmlWithIndentation:(int)indentationLevel
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

- (NSString *)description
{
    NSString *className = NSStringFromClass([self class]);
    return [NSString stringWithFormat:@"<%@: %p>", className, self];
}

@end
