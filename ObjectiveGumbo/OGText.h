//
//  OGText.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OGText : OGNode

@property (nonatomic, assign, readonly) BOOL isComment;
@property (nonatomic, assign, readonly) BOOL isCData;
@property (nonatomic, assign, readonly) BOOL isWhitespace;
@property (nonatomic, assign, readonly) BOOL isText;

@property (nonatomic, copy, readonly) NSString *text;

@end

@interface OGComment : OGText
@end

@interface OGCDataSection : OGText
@end

NS_ASSUME_NONNULL_END
