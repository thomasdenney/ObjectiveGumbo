//
//  OGDocument.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGElement.h"

@interface OGDocument : OGElement

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *publicIdentifier;
@property (nonatomic, copy) NSString *systemIdentifier;

@end
