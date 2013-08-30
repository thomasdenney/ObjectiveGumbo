//
//  OGElement.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGElement.h"

@implementation OGElement

-(NSString*)text
{
    NSMutableString * text = [NSMutableString new];
    for (OGNode * child in self.children)
    {
        [text appendString:[child text]];
    }
    return text;
}

-(NSString*)html
{
    NSMutableString * html = [NSMutableString stringWithFormat:@"<%@", [OGUtility tagForGumboTag:self.tag]];
    for (NSString * attribute in self.attributes)
    {
        [html appendFormat:@" %@=\"%@\"", attribute, [self.attributes[attribute]  escapedString]];
    }
    if (self.children.count == 0)
    {
        [html appendString:@" />"];
    }
    else
    {
        [html appendString:@">"];
        for (OGNode * child in self.children)
        {
            [html appendString:[child html]];
        }
        [html appendFormat:@"</%@>", [OGUtility tagForGumboTag:self.tag]];
    }
    return html;
}

-(NSArray*)selectWithBlock:(SelectorBlock)block
{
    NSMutableArray * matchingChildren = [NSMutableArray new];
    for (OGNode * child in self.children)
    {
        if (block(child))
        {
            [matchingChildren addObject:child];
        }
    }
    return matchingChildren;
}

-(NSArray*)elementsWithAttribute:(NSString *)attribute andValue:(NSString *)value
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            if ([element.attributes objectForKey:attribute] != nil)
            {
                return [element.attributes[attribute] isEqualToString:value];
            }
        }
        return NO;
    }];
}

-(NSArray*)elementsWithClass:(NSString*)class
{
    NSMutableArray * elements = [NSMutableArray new];
    
    for (NSString * classes in self.classes)
    {
        if ([classes isEqualToString:class])
        {
            [elements addObject:self];
            break;
        }
    }
    
    for (OGNode * child in self.children)
    {
        [elements addObjectsFromArray:[child elementsWithClass:class]];
    }
    
    
    return elements;
}

-(NSArray*)elementsWithID:(NSString *)id
{
    NSMutableArray * elements = [NSMutableArray new];
    if ([self.attributes objectForKey:@"id"] != nil && [(NSString*)[self.attributes objectForKey:@"id"] isEqualToString:id])
    {
        [elements addObject:self];
    }
    for (OGNode * child in self.children)
    {
        [elements addObjectsFromArray:[child elementsWithID:id]];
    }
    return elements;
}

-(NSArray*)elementsWithTag:(GumboTag)tag
{
    NSMutableArray * elements = [NSMutableArray new];
    if (self.tag == tag)
    {
        [elements addObject:self];
    }
    for (OGNode * child in self.children)
    {
        [elements addObjectsFromArray:[child elementsWithTag:tag]];
    }
    return elements;
}

@end
