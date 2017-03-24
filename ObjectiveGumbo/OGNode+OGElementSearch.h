//
//  OGNode+OGElementSearch.h
//  Pods
//
//  Created by Richard Warrender on 21/03/2017.
//
//

#import "OGNode.h"
#import "OGElement.h"

@interface OGNode (OGElementSearch)

//Usage:
//#stuffwiththisid .orthisclass orthistag
-(NSArray<OGNode *> *)select:(NSString*)selector;
-(NSArray<OGNode *> *)selectWithBlock:(SelectorBlock)block;

//Returns the first OGNode from the select:
-(OGElement *)first:(NSString*)selector;
-(OGElement *)last:(NSString*)selector;

- (NSArray <OGElement*>*)elementsWithAttribute:(NSString *)attribute
                                      andValue:(NSString *)value;

- (NSArray<OGElement*> *)elementsWithClass:(NSString*)class;
- (NSArray<OGElement*> *)elementsWithID:(NSString *)elementId;
- (NSArray<OGElement*> *)elementsWithTag:(GumboTag)tag;

@end
