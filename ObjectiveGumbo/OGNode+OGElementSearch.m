//
//  OGNode+OGElementSearch.m
//  Pods
//
//  Created by Richard Warrender on 21/03/2017.
//
//

#import "OGNode+OGElementSearch.h"

@implementation OGNode (OGElementSearch)

-(NSArray<OGNode *> *)select:(NSString *)selector
{
    NSArray<NSString *>* selectors = [selector componentsSeparatedByString:@" "];
    NSMutableArray<OGNode *> * allMatchingObjects = [NSMutableArray new];
    for (NSString *individualSelector in selectors)
    {
        if ([individualSelector hasPrefix:@"#"])
        {
            [allMatchingObjects addObjectsFromArray:[self elementsWithID:[individualSelector substringFromIndex:1]]];
        }
        else if ([individualSelector hasPrefix:@"."])
        {
            [allMatchingObjects addObjectsFromArray:[self elementsWithClass:[individualSelector substringFromIndex:1]]];
        }
        else
        {
            [allMatchingObjects addObjectsFromArray:[self elementsWithTag:[OGUtility gumboTagForTag:individualSelector]]];
        }
    }
    
    //Remove duplicates
    NSOrderedSet *set = [[NSOrderedSet alloc] initWithArray:allMatchingObjects];
    allMatchingObjects = [[NSMutableArray alloc] initWithArray:[set array]];
    
    return allMatchingObjects;
}

-(NSArray<OGNode *> *)selectWithBlock:(SelectorBlock)block
{
    return [NSArray new];
}

-(OGNode *)first:(NSString *)selector
{
    return [[self select:selector] firstObject];
}

-(OGNode *)last:(NSString *)selector
{
    return [[self select:selector] lastObject];
}

- (NSArray<OGElement*> *)elementsWithAttribute:(NSString *)attribute andValue:(NSString *)value
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            return [element.attributes[attribute] isEqualToString:value];
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithClass:(NSString*)class
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            for (NSString * classes in element.classes)
            {
                if ([classes isEqualToString:class])
                {
                    return YES;
                }
            }
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithID:(NSString *)elementId
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]]) {
            OGElement * element = (OGElement*)node;
            return [(NSString*)element.attributes[@"id"] isEqualToString:elementId];
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithTag:(GumboTag)tag
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            return element.tag == tag;
        }
        return NO;
    }];
}

@end
