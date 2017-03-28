//
//  OGNode_OGNodeProtected.h
//  Pods
//
//  Created by Richard Warrender on 24/03/2017.
//
//

#import "ObjectiveGumbo.h"

@interface OGNode ()
@property (nonatomic, weak) OGNode *parent;
@property (nonatomic, weak) OGDocument *ownerDocument;
@property (nonatomic, strong) NSArray<OGNode *> *children;

@property (nonatomic, weak) OGNode *nextSibling;
@property (nonatomic, weak) OGNode *previousSibling;

- (instancetype)initWithGumboNode:(GumboNode *)gumboNode;
@end

@interface OGText ()
+ (instancetype)textNodeWithText:(NSString *)text andType:(GumboNodeType)type;
@end
