// OGText.h
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
#import "OGTypes.h"

/**
 Represents a raw text node in the DOM. Raw text nodes are not surrounded by HTML tags. To get the raw text call the -(NSString*)text (a method defined by OGNode)
 @see OGNode
 */
@interface OGText : OGNode

@property (readonly) BOOL isComment;
@property (readonly) BOOL isCData;
@property (readonly) BOOL isWhitespace;
@property (readonly) BOOL isText;

/**
 Initializes a text node with the given text type
 @param parent The parent node that this node is a child of
 @param text The text content of the node
 @param type The node type. Must by OGNodeTypeText, OGNodeTypeComment, OGNodeTypeWhitespace or OGNodeTypeCData
 @return A text object
 @note The text will not be set unless the type is a valid text type as described above
 */
- (instancetype)initWithParent:(OGNode*)parent text:(NSString*)text type:(OGNodeType)type;

@end
