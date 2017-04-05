//
//  OGNode+OGElementSearch.m
//  Pods
//
//  Created by Richard Warrender on 21/03/2017.
//
//

#import "OGNode+OGElementSearch.h"

@interface NSMutableArray (OGElementSearch)
- (void)addUniqueObjectsFromArray:(NSArray *)otherArray;
@end


@interface NSString (OGElementSearch)
- (NSArray<NSString *> *)selectorGroups;
- (NSArray<NSString *> *)individualSelectors;
@end


@implementation NSMutableArray (OGElementSearch)
- (void)addUniqueObjectsFromArray:(NSArray *)otherArray
{
    for (id item in otherArray) {
        if (![self containsObject:item]) {
            [self addObject:item];
        }
    }
}
@end


@implementation NSString (OGElementSearch)
- (NSArray<NSString *> *)selectorGroups
{
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@","];
}
- (NSArray<NSString *> *)individualSelectors
{
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@" "];
}
@end


@implementation OGNode (OGElementSearch)

- (NSArray *)objectForKeyedSubscript:(NSString *)key
{
    return [self select:key];
}

- (NSArray<OGNode *> *)select:(NSString *)selectInput
{
    NSString *selectorGroups = [selectInput selectorGroups];

    NSMutableArray *allElements = [NSMutableArray array];
    
    for (NSString *selectorGroup in selectorGroups)
    {
        NSArray<NSString *>* individualSelectors = [selectorGroup individualSelectors];
        
        NSArray *elements = @[self];
        for (NSString *individualSelector in individualSelectors) {
            elements = [OGNode filteredElementsUsingSelector:individualSelector fromElements:elements];
        }
        
        [allElements addUniqueObjectsFromArray:elements];
    }
    
    return allElements.copy;
}

+ (NSArray<OGElement*>*)filteredElementsUsingSelector:(NSString *)selector
                                         fromElements:(NSArray<OGElement *>*)elements
{
    NSMutableArray *filteredElements = [NSMutableArray array];
    for (OGElement *element in elements) {
        [filteredElements addObjectsFromArray:[OGNode filteredElementsUsingSelector:selector fromElement:element]];
    }
    
    return filteredElements.copy;
}

+ (NSArray<OGElement*>*)filteredElementsUsingSelector:(NSString *)selector
                                          fromElement:(OGElement *)element
{
    NSMutableArray *elements = [NSMutableArray array];
    if ([selector hasPrefix:@"#"]) {
        elements = @[[element elementWithID:[selector substringFromIndex:1]]];
    }
    else if ([selector hasPrefix:@"."])
    {
        elements = [element elementsWithClass:[selector substringFromIndex:1]];
    }
    else if ([selector containsString:@"."]) {
        NSArray *selectorParts = [selector componentsSeparatedByString:@"."];
        elements = [element elementsWithTag:OGTagFromNSString(selectorParts[0]) class:selectorParts[1]];
    }
    else if ([selector hasPrefix:@"*"])
    {
        elements = element.children;
    }
    else
    {
        elements = [element elementsWithTag:OGTagFromNSString(selector)];
    }
    
    return elements;
}

- (NSArray<OGNode *> *)selectWithBlock:(SelectorBlock)block
{
    return [[NSArray alloc] init];
}

- (OGNode *)selectFirstWithBlock:(SelectorBlock)block
{
    return nil;
}

- (OGNode *)first:(NSString *)selector
{
    return [[self select:selector] firstObject];
}

- (OGNode *)last:(NSString *)selector
{
    return [[self select:selector] lastObject];
}

- (NSArray<OGElement*> *)elementsWithAttribute:(NSString *)attribute
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            return (element.attributes[attribute] != nil);
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithAttribute:(NSString *)attribute value:(NSString *)value
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

- (NSArray<OGElement*> *)elementsWithClass:(NSString*)className
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            for (NSString * classes in element.classes)
            {
                if ([classes isEqualToString:className])
                {
                    return YES;
                }
            }
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag class:(NSString*)className
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            if (element.tag != tag) {
                return NO;
            }
            
            for (NSString * classes in element.classes)
            {
                if ([classes isEqualToString:className])
                {
                    return YES;
                }
            }
        }
        return NO;
    }];
}

- (nullable OGElement *)elementWithID:(NSString *)elementId
{
    return [self selectFirstWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]]) {
            OGElement * element = (OGElement *)node;
            return [(NSString*)element.attributes[@"id"] isEqualToString:elementId];
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag
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

- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag attribute:(NSString *)attribute
{
    return [self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            return ((element.tag == tag) && (element.attributes[attribute] != nil));
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsForRDFaProperty:(NSString *)targetProperty
{
    NSMutableArray *newElements = [NSMutableArray array];
    
    NSArray<OGElement*> *elements = [self elementsWithAttribute:@"property"];
    for (OGElement *element in elements) {
        NSString *property = element.attributes[@"property"];
        
        if ([property isEqualToString:targetProperty]) {
            [newElements addObject:element];
        } else if ([property containsString:@" "]) { // Check if we have mupltiple white space properties
            NSArray<NSString *>* innerProperties = [property componentsSeparatedByString:@" "];
            for (NSString *innerProperty in innerProperties) {
                if ([innerProperty isEqualToString:targetProperty]) {
                    [newElements addObject:element];
                    break;
                }
            }
        }
    }
    
    return newElements.copy;
}

- (OGElement *)firstElementForRDFaProperty:(NSString *)property
{
    return [[self elementsWithAttribute:@"property" value:property] firstObject];
}

- (NSString *)RDFaProperty
{
    if ([self isKindOfClass:[OGElement class]])
    {
        OGElement *element = (OGElement *)self;
        return element.attributes[@"property"];
    }
    return nil;
}

- (NSString *)RDFaResolvedProperty
{
    if ([self isKindOfClass:[OGElement class]])
    {
        OGElement *element = (OGElement *)self;
        return element.attributes[@"property"];
    }
    return nil;
}


@end
