// OGNode.m
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

#import "OGNode.h"

@implementation OGNode

#pragma mark - Initialization

- (instancetype)initWithParent:(OGNode *)parent {
    self = [super init];
    if (self) {
        _parent = parent;
    }
    return self;
}

- (NSString*)text {
    //This method is implemented by subclasses
    return @"";
}

- (NSString*)html {
    return [self htmlWithIndentation:0];
}

- (NSString*)htmlWithIndentation:(NSInteger)indentationLevel {
    //This method is implemented by subclasses
    return @"";
}

- (NSArray*)select:(NSString *)selector {
    NSArray * selectors = [selector componentsSeparatedByString:@" "];
    //By using a set you ensure that the same tag is not added more than once
    NSMutableSet * allMatchingObjects = [NSMutableSet new];
    for (NSString * individualSelector in selectors) {
        if ([individualSelector hasPrefix:@"#"]) {
            [allMatchingObjects addObjectsFromArray:[self elementsWithID:[individualSelector substringFromIndex:1]]];
        }
        else if ([individualSelector hasPrefix:@"."]) {
            [allMatchingObjects addObjectsFromArray:[self elementsWithClass:[individualSelector substringFromIndex:1]]];
        }
        else {
            [allMatchingObjects addObjectsFromArray:[self elementsWithTag:[OGTypes gumboTagForTag:individualSelector]]];
        }
    }
    
    return allMatchingObjects.allObjects;
}

- (NSArray*)selectWithBlock:(BOOL(^)(OGNode*))block {
    return [NSArray new];
}

- (OGNode*)first:(NSString *)selector {
    //TODO: This completes in O(n) time when it could complete in O(1). Fix that
    return [[self select:selector] firstObject];
}

- (OGNode*)last:(NSString *)selector {
    return [[self select:selector] lastObject];
}

- (NSArray*)elementsWithClass:(NSString*)class {
    return [NSArray new];
}

- (NSArray*)elementsWithID:(NSString *)id {
    return [NSArray new];
}

- (NSArray*)elementsWithTag:(OGTag)tag {
    return [NSArray new];
}

@end
