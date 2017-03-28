//
//  OGDocument.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGNode.h"
#import "OGElement.h"

/**
 * Indicates quirks mode that should be triggered based on provided doctype
 * See https://en.wikipedia.org/wiki/Quirks_mode for more info
 */
typedef NS_ENUM(NSInteger, OGDocumentDocType) {
    OGDocumentDocTypeNoQuirks,          /* Document is being read using strict mode */
    OGDocumentDocTypeQuirks,            /* Document is using full quirks mode */
    OGDocumentDocTypeLimitedQuirks      /* Document is being read using almost mode */
};

/**
 * Converts OGDocType enum to an NSString for use in logging to the console
 */
NSString* NSStringFromOGDocType(OGDocumentDocType quirksMode);

@interface OGDocument : OGElement

/**
 * Indicates document has provided a doc type and it isn't automatically inferred.
 */
@property (nonatomic, assign, readonly) BOOL hasDocType;

/**
 * Shortcut for seeing if quirks mode should be enabled
 */
@property (nonatomic, assign, readonly) BOOL quirksMode;

/**
 * The doctype name. This will usually be html
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 * Doctype Public identifier if one is specified
 */
@property (nonatomic, copy, readonly) NSString *publicIdentifier;

/**
 * Doctype Public identifier if one is specified
 */
@property (nonatomic, copy, readonly) NSString *systemIdentifier;

@end
