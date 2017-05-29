//
//  OGNode.m
//  ObjectiveGumbo
//
//  Copyright (c) 2017 Richard Warrender. All rights reserved.
//

#import "OGNode.h"
#import "OGNodePrivate.h"

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

- (BOOL)isDescendantOfNode:(OGNode *)node
{
    return [node isAncestorOfNode:self];
}

- (BOOL)isAncestorOfNode:(OGNode *)node
{
    
    if (node == nil || node == self) {
        return NO;
    }
    
    OGNode *target = node;
    while( (target = (OGElement *)target.parent) ) {
        if (target == self) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)description
{
    NSString *className = NSStringFromClass([self class]);
    return [NSString stringWithFormat:@"<%@: %p>", className, self];
}

@end
