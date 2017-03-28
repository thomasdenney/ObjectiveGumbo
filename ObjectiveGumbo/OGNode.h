//
//  OGNode.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OGUtility.h"
#import "NSString+OGString.h"

typedef BOOL(^SelectorBlock)(id node);

@class OGDocument;

@interface OGNode : NSObject

@property (nonatomic, weak, readonly) OGDocument *ownerDocument;
@property (nonatomic, weak, readonly) OGNode *parent;
@property (nonatomic, strong, readonly) NSArray<OGNode *> *children;

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSString *html;

@property (nonatomic, readonly) OGNode *first;
@property (nonatomic, readonly) OGNode *last;

@property (nonatomic, weak, readonly) OGNode *nextSibling;
@property (nonatomic, weak, readonly) OGNode *previousSibling;

-(NSString *)htmlWithIndentation:(int)indentationLevel;

@end
