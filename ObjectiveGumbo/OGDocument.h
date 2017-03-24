//
//  OGDocument.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"
#import "OGElement.h"

typedef NS_ENUM(NSInteger, OGDocumentDocType) {
    OGDocumentDocTypeNoQuirks,
    OGDocumentDocTypeQuirks,
    OGDocumentDocTypeLimitedQuirks
};

NSString* NSStringFromOGDocType(OGDocumentDocType quirksMode);

@interface OGDocument : OGElement

@property (nonatomic, assign, readonly) BOOL hasDocType;
@property (nonatomic, assign, readonly) BOOL quirksMode;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *publicIdentifier;
@property (nonatomic, copy, readonly) NSString *systemIdentifier;

@end
