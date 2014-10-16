// OGNode.h
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

@import Foundation;

#import "OGUtility.h"
#import "NSString+OG.h"

typedef BOOL(^SelectorBlock)(id node);

@interface OGNode : NSObject

@property OGNode * parent;

-(NSString*)text;
-(NSString*)html;
-(NSString*)htmlWithIndentation:(int)indentationLevel;

//Usage:
//#stuffwiththisid .orthisclass orthistag
-(NSArray*)select:(NSString*)selector;
-(NSArray*)selectWithBlock:(SelectorBlock)block;

//Returns the first OGNode from the select:
-(OGNode*)first:(NSString*)selector;
-(OGNode*)last:(NSString*)selector;

-(NSArray*)elementsWithClass:(NSString*)class;
-(NSArray*)elementsWithID:(NSString*)id;
-(NSArray*)elementsWithTag:(GumboTag)tag;

@end
