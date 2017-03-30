//
//  OGElement.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"
#import "OGTags.h"

NS_ASSUME_NONNULL_BEGIN

@interface OGElement : OGNode

@property (nonatomic, assign, readonly) OGTag tag;
@property (nonatomic, assign, readonly) OGNamespace tagNamespace;

@property (nonatomic, strong, readonly) NSArray *classes;
@property (nonatomic, strong, readonly) NSDictionary *attributes;

@end

NS_ASSUME_NONNULL_END
