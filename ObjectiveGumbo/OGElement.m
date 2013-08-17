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
