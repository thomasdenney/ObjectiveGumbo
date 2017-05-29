//
//  OGNodePrivate.h
//  ObjectiveGumbo
//
//  Copyright (c) 2017 Richard Warrender. All rights reserved.
//
//

#import "ObjectiveGumbo.h"
#import "gumbo.h"

// This header is only for classes that wish to mutate the non-mutable nodes, not recommended unless you know what you're doing!

NS_ASSUME_NONNULL_BEGIN

@interface OGNode ()
@property (nonatomic, weak, nullable) OGNode *parent;
@property (nonatomic, weak, nullable) OGDocument *ownerDocument;
@property (nonatomic, strong) NSArray<OGNode *> *children;

@property (nonatomic, weak, nullable) OGNode *nextSibling;
@property (nonatomic, weak, nullable) OGNode *previousSibling;

- (instancetype)initWithGumboNode:(GumboNode *)gumboNode;
@end

@interface OGText ()
+ (instancetype)textNodeWithText:(NSString *)text andType:(GumboNodeType)type;
@end

NS_ASSUME_NONNULL_END
