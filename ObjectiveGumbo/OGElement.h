//
//  OGElement.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"

@interface OGElement : OGNode

@property (nonatomic, assign) GumboTag tag;
@property (nonatomic, assign) GumboNamespaceEnum tagNamespace;

@property (nonatomic, strong) NSArray *classes;
@property (nonatomic, strong) NSDictionary *attributes;

@end
