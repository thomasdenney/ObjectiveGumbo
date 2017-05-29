//
//  OGNode+OGElementSearch.m
//  ObjectiveGumbo
//
//  Copyright (c) 2017 Richard Warrender. All rights reserved.
//
//

#import "OGNode+OGElementSearch.h"

@interface NSMutableArray (OGElementSearch)
- (void)addUniqueObjectsFromArray:(NSArray *)otherArray;
@end


@interface NSString (OGElementSearch)

/**
 Useful for extracting groups of CSS selectors seperated by a , e.g. ".header, .footer"
 */
- (NSArray<NSString *> *)selectorGroups;

/**
 Useful for extracting individual CSS selectors in a selector group string such as ".header div.intro"
 */
- (NSArray<NSString *> *)individualSelectors;

/**
 Split up and return valid class selectors
 */
- (NSArray<NSString *> *)classSelectors;

/**
 Split a string in two parts when it encounters the string parameter
 */
- (NSArray<NSString *> *)componentsChoppedByString:(NSString *)string;
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
// p.test = @"p" "test"
// .test = @"", "test"
// .test.info = @"", @"test.info"
- (NSArray<NSString *> *)componentsChoppedByString:(NSString *)string
{
    // Always return an array with two strings in even if it has empty last part
    NSRange range = [self rangeOfString:string];
    
    // chop mark string not found, return empty strings
    if (range.location == NSNotFound)
    {
        return [NSArray arrayWithObjects:self, @"", nil];
    }
    // chop mark string at the beginning, move everything into second string
    else if (range.location == 0) {
        NSString *secondPart = [self substringFromIndex:range.location + 1];
        return [NSArray arrayWithObjects:@"", secondPart, nil];
    } else {
        NSString *firstPart = [self substringToIndex:range.location];
        NSString *secondPart = [self substringFromIndex:range.location + 1];
        return [NSArray arrayWithObjects:firstPart, secondPart, nil];
    }
}
- (NSArray<NSString *> *)classSelectors
{
    NSMutableArray *selectors = [NSMutableArray array];
    
    NSUInteger i = 0, stringLength = self.length;
    
    NSRange selectorRange, searchRange, dotRange;
    while (i < stringLength) {
        searchRange = NSMakeRange(i, stringLength - i);
        dotRange = [self rangeOfString:@"." options:0 range:searchRange];
        
        if (dotRange.location != NSNotFound) {
            selectorRange = NSMakeRange(i, (dotRange.location - i));
        } else {
            // Handle case where we are at the end of the string with no more .'s
            selectorRange = searchRange;
        }
        
        // Only ensure whole selectors get added
        if (selectorRange.length > 0) {
            NSString *selector = [self substringWithRange:selectorRange];
            [selectors addObject:selector];
        }
        i += selectorRange.length + dotRange.length;
    }
    
    return selectors.copy;
}
@end


@implementation OGNode (OGElementSearch)

- (NSArray *)objectForKeyedSubscript:(NSString *)key
{
    return [self select:key];
}

- (NSArray<OGNode *> *)select:(NSString *)selectInput
{
    NSArray<NSString *>* selectorGroups = [selectInput selectorGroups];

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
        NSArray *array = [OGNode filteredElementsUsingSelector:selector fromElement:element];
         [filteredElements addObjectsFromArray:array];
    }
    
    return filteredElements.copy;
}

+ (NSArray<OGElement*>*)filteredElementsUsingSelector:(NSString *)selector
                                          fromElement:(OGElement *)element
{
    NSArray<OGElement*>* elements = [NSArray array];
    if ([selector hasPrefix:@"#"]) {
        
        // Chop off any class selectors
        NSRange range = [selector rangeOfString:@"."];
        if (range.location != NSNotFound) {
            selector = [selector substringToIndex:range.location];
        }
        
        OGElement *newElement = [element elementWithID:[selector substringFromIndex:1]];
        if (newElement) {
            elements = @[newElement];
        }
    }
    else if ([selector containsString:@"."]) {
        NSArray<NSString *> *selectorParts = [selector componentsChoppedByString:@"."];
        
        if ([selectorParts[0] isEqualToString:@""]) {
            elements = [element elementsWithClass:[selector substringFromIndex:1]];
        } else {
            elements = [element elementsWithTag:OGTagFromNSString(selectorParts[0]) class:selectorParts[1]];
        }
    }
    else if ([selector hasPrefix:@"*"])
    {
        elements = (NSArray<OGElement*>*)element.children;
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
    return (NSArray<OGElement*> *)[self selectWithBlock:^BOOL(id node) {
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
    return (NSArray<OGElement*> *)[self selectWithBlock:^BOOL(id node) {
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
    NSArray<NSString *>* targetClasses = [className classSelectors];
    if (targetClasses.count == 0) {
        return [NSArray array];
    }
    
    return (NSArray<OGElement*> *)[self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            for (NSString *targetClassName in targetClasses) {
                if (![element.classes containsObject:targetClassName]) {
                    return NO;
                }
            }
            return YES;
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag class:(NSString*)className
{
    NSArray<NSString *>* targetClasses = [className classSelectors];
    if (targetClasses.count == 0) {
        return [NSArray array];
    }
    
    return (NSArray<OGElement*> *)[self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            if (element.tag != tag) {
                return NO;
            }
            
            for (NSString *targetClassName in targetClasses) {
                if (![element.classes containsObject:targetClassName]) {
                    return NO;
                }
            }
            return YES;
        }
        return NO;
    }];
}

- (nullable OGElement *)elementWithID:(NSString *)elementId
{
    return (OGElement*)[self selectFirstWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]]) {
            OGElement * element = (OGElement *)node;
            return [(NSString*)element.attributes[@"id"] isEqualToString:elementId];
        }
        return NO;
    }];
}

- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag
{
    return (NSArray<OGElement*> *)[self selectWithBlock:^BOOL(id node) {
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
    return (NSArray<OGElement*> *)[self selectWithBlock:^BOOL(id node) {
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
