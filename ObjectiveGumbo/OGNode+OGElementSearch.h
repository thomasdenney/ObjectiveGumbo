//
//  OGNode+OGElementSearch.h
//  Pods
//
//  Created by Richard Warrender on 21/03/2017.
//
//

#import "OGNode.h"
#import "OGElement.h"

NS_ASSUME_NONNULL_BEGIN

/**
 This category contains a number of useful methods for searching within the DOM tree for particular OGElements.
 */
 @interface OGNode (OGElementSearch)

- (NSArray *)objectForKeyedSubscript:(NSString *)key;

/** Returns an array of nodes matching the given CSS selector e.g. #name for ID, .name for class or name for tag */
- (NSArray<OGNode *> *)select:(NSString*)selector;

/** Returns an array of nodes that return from the given block */
- (NSArray<OGNode *> *)selectWithBlock:(SelectorBlock)block;

/** Returns the first array found that matches the given block */
- (nullable OGNode *)selectFirstWithBlock:(SelectorBlock)block;

/** Returns the first OGNode from the matching selector */
- (nullable OGElement *)first:(NSString*)selector;

/** Returns the last OGNode from the matching selector */
- (nullable OGElement *)last:(NSString*)selector;

/** Returns an array containing elements matching IDs although this should only return 1 element */
- (nullable OGElement *)elementWithID:(NSString *)elementID;

/** Returns an array containing elements matching the given HTML attribute and value */
- (NSArray <OGElement*>*)elementsWithAttribute:(NSString *)attribute
                                         value:(NSString *)value;

/** Returns an array containing elements matching the given HTML tag and attribute */
- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag
                               attribute:(NSString *)attribute;

/** Returns an array containing elements matching the given HTML class name */
- (NSArray<OGElement*> *)elementsWithClass:(NSString*)className;

/** Returns an array containing elements matching the given HTML tag */
- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag;

- (NSArray<OGElement*> *)elementsWithTag:(OGTag)tag
                                   class:(NSString*)className;


/** Returns all the element that matches a given RDFa property */
- (NSArray<OGElement*> *)elementsForRDFaProperty:(NSString *)property;

/** Returns the first element that matches a given RDFa property */
- (nullable OGElement *)firstElementForRDFaProperty:(NSString *)property;

/** Returns the RDFa property value of a given element */
@property (nonatomic, readonly, nullable) NSString *RDFaProperty;

@end

NS_ASSUME_NONNULL_END
