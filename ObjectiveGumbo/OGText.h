//
//  OGText.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"

@interface OGText : OGNode

@property (nonatomic, assign) BOOL isComment;
@property (nonatomic, assign) BOOL isCData;
@property (nonatomic, assign) BOOL isWhitespace;
@property (nonatomic, assign) BOOL isText;

- (instancetype)initWithText:(NSString*)text andType:(GumboNodeType)type;

@end
