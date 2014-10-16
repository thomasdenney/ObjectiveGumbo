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

#import "OGTypes.h"
#import "NSString+OG.h"

/**
 Abstract class used to define a node. Nodes are either HTML elements, documents or raw text (such as a comment, whitespace or element contents). All nodes (irrespective of their type) are immutable as Objective Gumbo is only designed to be a parser, rather than an HTML manipulator.
 @warning You generally do not need to use this class directly
 @see OGDocument, OGElement, OGText
 */
@interface OGNode : NSObject

///---------------
///@name Hierarchy
///---------------

/**
 The parent node of the current node
 */
@property (readonly) OGNode * parent;

///-----------------------------
///@name Node contents or source
///-----------------------------

/**
 @return The raw text contents of the node. If the node is an element this will included its children.
 */
- (NSString*)text;

/**
 @return HTML source that represents this node.
 @note This method doesn't return the original HTML source, but generates it based on known attributes, elements and contents. The source is therefore 'standard' HTML5 which is indented using 4 spaces. Elements are positioned on new lines.
 */
- (NSString*)html;

/**
 @return HTML source that represents this node
 @note This method doesn't return the original HTML source, but generates it based on known attributes, elements and contents. The source is therefore 'standard' HTML5 which is indented using 4 spaces + the provided indentation level. This means that this class is useful for generating hierarchies of HTML. Elements are positioned on new lines.
 */
- (NSString*)htmlWithIndentation:(NSUInteger)indentationLevel;

//Usage:
//#stuffwiththisid .orthisclass orthistag

///------------------------
///@name Filtering children
///------------------------

/**
 jQuery style selection for nodes. You can use multiple selectors at once for OR style matching (e.g. p .grey finds all paragraph tags or all tags with the 'grey' class applied).
 TODO: Support AND requirements. The DSL will get more complex...
 @param selector A string that you can use to find children of a specific type:
  - #someIdentifier: Find children with a given ID (if it is valid HTML this array will only contain one element
  - .someClass: Find children with a given class
  - tag: Find children with a given tag type
 @note This is a high level method that should not be used in high performance scenarios due to DSL parsing
 @return An array of nodes that are children of this node and match the criteria
 */
- (NSArray*)select:(NSString*)selector;

/**
 Calls the provided block with each child of this node to determine whether or not to include it in the output array. Can be used for filtering
 @param shouldUseNode A block which should return YES if the node should be included in the filtered results
 @return An array of child nodes of this node that have been filtered into the output
 */
- (NSArray*)selectWithFilter:(BOOL(^)(OGNode*))shouldUseNodeFilter;

/**
 Applies the jQuery style selection in the standard select method to only return the first element that matches the criteria
 @return The first node to match the selection criteria
 @note Can return nil if no matching nodes were found
 */
- (OGNode*)first:(NSString*)selector;

/**
 Applies the jQuery style selection in the standard select method to only return the last element that matches the criteria
 @return The last node to match the selection criteria
  @note Can return nil if no matching nodes were found
 */
- (OGNode*)last:(NSString*)selector;

/**
 @param className name to search for. This doesn't need the preceding . (dot)
 @return An array of child OGNode objects of this node that match the CSS class provided
 */
- (NSArray*)elementsWithClass:(NSString*)className;

/**
 @param identifier An id to search for. This doesn't require the preceding # (hash)
 @return An array of child OGNode objects of this node that have the provided ID
 @note If the HTML conforms this should contain 0 or 1 elements
 */
- (NSArray*)elementsWithID:(NSString*)identifier;

/**
 @param tag A tag type to search for
 @return An array of nodes that match the given tag type that are also children of this node
 TODO: Should this only return OGElement objects?
 */
- (NSArray*)elementsWithTag:(OGTag)tag;

@end
