// OGElement.m
//
// Copyright 2014 Programming Thomas
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "OGElement.h"
#import "_OGMutableElement.h"
#import "gumbo.h"

@implementation OGElement

- (NSString*)text {
    NSMutableString * text = [NSMutableString new];
    for (OGNode * child in self.children) {
        [text appendString:[child text]];
        if (child != self.children.lastObject) {
            [text appendString:@" "];
        }
    }
    return text;
}

- (NSString*)htmlWithIndentation:(NSUInteger)indentationLevel {
    NSMutableString * html = [NSMutableString stringWithFormat:@"<%@", [OGTypes tagForGumboTag:self.tag]];
    for (NSString * attribute in self.attributes) {
        [html appendFormat:@" %@=\"%@\"", attribute, [self.attributes[attribute]  og_escapedString]];
    }
    if (self.children.count == 0) {
        [html appendString:@" />\n"];
    }
    else {
        [html appendString:@">\n"];
        for (OGNode * child in self.children) {
            [html appendString:[child htmlWithIndentation:indentationLevel + 1]];
        }
        [html appendFormat:@"</%@>\n", [OGTypes tagForGumboTag:self.tag]];
    }
    return html;
}

- (NSArray*)selectWithFilter:(BOOL (^)(OGNode *))shouldUseNodeFilter {
    NSMutableArray * matchingChildren = [NSMutableArray new];
    for (OGNode * child in self.children) {
        if (shouldUseNodeFilter(child)) {
            [matchingChildren addObject:child];
        }
        [matchingChildren addObjectsFromArray:[child selectWithFilter:shouldUseNodeFilter]];
    }
    return matchingChildren;
}

- (NSArray*)elementsWithAttribute:(NSString *)attribute andValue:(NSString *)value {
    return [self selectWithFilter:^BOOL(OGNode * node) {
        if ([node isKindOfClass:[OGElement class]]) {
            OGElement * element = (OGElement*)node;
            return [element.attributes[attribute] isEqualToString:value];
        }
        return NO;
    }];
}

- (NSArray*)elementsWithClass:(NSString*)class {
    return [self selectWithFilter:^BOOL(OGNode * node) {
        if ([node isKindOfClass:[OGElement class]]) {
            OGElement * element = (OGElement*)node;
            for (NSString * classes in element.classes) {
                if ([classes isEqualToString:class]) {
                    return YES;
                }
            }
        }
        return NO;
    }];
}

- (NSArray*)elementsWithID:(NSString *)elementId {
    return [self selectWithFilter:^BOOL(OGNode * node) {
        if ([node isKindOfClass:[OGElement class]]) {
            OGElement * element = (OGElement*)node;
            return [(NSString*)element.attributes[@"id"] isEqualToString:elementId];
        }
        return NO;
    }];
}

- (NSArray*)elementsWithTag:(OGTag)tag {
    return [self selectWithFilter:^BOOL(OGNode * node) {
        if ([node isKindOfClass:[OGElement class]]) {
            OGElement * element = (OGElement*)node;
            return element.tag == tag;
        }
        return NO;
    }];
}

@end

@implementation OGElement (Mutable)

- (void)setTag:(OGTag)tag {
    _tag = tag;
}

- (void)setTagNamespace:(OGNamespace)tagNamespace {
    _tagNamespace = tagNamespace;
}

- (void)setChildren:(NSArray*)children {
    _children = children;
}

- (void)setClasses:(NSArray*)classes {
    _classes = classes;
}

- (void)setAttributes:(NSDictionary*)attributes {
    _attributes = attributes;
}

@end
