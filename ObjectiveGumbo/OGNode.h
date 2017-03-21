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

@interface OGNode : NSObject

@property (nonatomic, weak) OGNode *parent;
@property (nonatomic, strong) NSArray<OGNode *> *children;

@property (nonatomic, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSString *html;

-(NSString*)htmlWithIndentation:(int)indentationLevel;

@property (nonatomic, readonly) OGNode *first;
@property (nonatomic, readonly) OGNode *last;

@end
