//
//  OGElement.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGElement.h"
#import "OGNode+OGElementSearch.h"

@implementation OGElement

-(NSString *)text
{
    NSMutableString * text = [NSMutableString new];
    for (OGNode * child in self.children)
    {
        [text appendString:[child text]];
    }
    return text;
}

-(NSString *)htmlWithIndentation:(int)indentationLevel
{
    NSMutableString * html = [NSMutableString stringWithFormat:@"<%@", [OGUtility tagForGumboTag:self.tag]];
    for (NSString * attribute in self.attributes)
    {
        [html appendFormat:@" %@=\"%@\"", attribute, [self.attributes[attribute]  escapedString]];
    }
    if (self.children.count == 0)
    {
        [html appendString:@" />\n"];
    }
    else
    {
        [html appendString:@">\n"];
        for (OGNode * child in self.children)
        {
            [html appendString:[child htmlWithIndentation:indentationLevel + 1]];
        }
        [html appendFormat:@"</%@>\n", [OGUtility tagForGumboTag:self.tag]];
    }
    return html;
}

-(NSArray<OGNode *> *)selectWithBlock:(SelectorBlock)block
{
    NSMutableArray * matchingChildren = [NSMutableArray new];
    for (OGNode * child in self.children)
    {
        if (block(child))
        {
            [matchingChildren addObject:child];
        }
        [matchingChildren addObjectsFromArray:[child selectWithBlock:block]];
    }
    return matchingChildren;
}

@end
