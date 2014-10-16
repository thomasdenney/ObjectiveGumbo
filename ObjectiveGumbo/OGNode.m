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

-(NSString*)text
{
    return @"";
}

-(NSString*)html
{
    return [self htmlWithIndentation:0];
}

-(NSString*)htmlWithIndentation:(int)indentationLevel
{
    return @"";
}

-(NSArray*)select:(NSString *)selector
{
    NSArray * selectors = [selector componentsSeparatedByString:@" "];
    NSMutableArray * allMatchingObjects = [NSMutableArray new];
    for (NSString * individualSelector in selectors)
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
    NSOrderedSet * set = [[NSOrderedSet alloc] initWithArray:allMatchingObjects];
    allMatchingObjects = [[NSMutableArray alloc] initWithArray:[set array]];
    
    return allMatchingObjects;
}

-(NSArray*)selectWithBlock:(SelectorBlock)block
{
    return [NSArray new];
}

-(OGNode*)first:(NSString *)selector
{
    return [[self select:selector] firstObject];
}

-(OGNode*)last:(NSString *)selector
{
    return [[self select:selector] lastObject];
}

-(NSArray*)elementsWithClass:(NSString*)class
{
    return [NSArray new];
}

-(NSArray*)elementsWithID:(NSString *)id
{
    return [NSArray new];
}

-(NSArray*)elementsWithTag:(GumboTag)tag
{
    return [NSArray new];
}

@end
