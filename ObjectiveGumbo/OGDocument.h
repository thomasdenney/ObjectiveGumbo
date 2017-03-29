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
    OGDocumentDocTypeNoQuirks,          /* Document is should use strict mode */
    OGDocumentDocTypeQuirks,            /* Document is should use full quirks mode */
    OGDocumentDocTypeLimitedQuirks      /* Document is should use almost mode */
};

/** Converts OGDocType enum to an NSString for use in logging to the console */
NSString* NSStringFromOGDocType(OGDocumentDocType quirksMode);

NS_ASSUME_NONNULL_BEGIN

@interface OGDocument : OGElement

/** Indicates document has provided a doc type and it isn't automatically inferred */
@property (nonatomic, assign, readonly) BOOL hasDocType;

/** Shortcut for seeing if quirks mode should be enabled */
@property (nonatomic, assign, readonly) BOOL quirksMode;

/** The doctype name. This will usually be HTML */
@property (nonatomic, copy, readonly) NSString *name;

/** Doctype Public identifier if one is specified */
@property (nonatomic, copy, readonly) NSString *publicIdentifier;

/** Doctype Public identifier if one is specified */
@property (nonatomic, copy, readonly) NSString *systemIdentifier;

/** Return a dictionary of @b meta elements with attribute names as the keys that are contained within the document. Note meta */
@property (nonatomic, strong, readonly) NSDictionary<NSString *, OGElement *>* meta;

/** Returns @b a elements that have name attributes contained within the document */
@property (nonatomic, strong, readonly) NSArray<OGElement *>* anchors;

/** Returns @b form elements contained within the document */
@property (nonatomic, strong, readonly) NSArray<OGElement *>* forms;

/** Returns @b img elements contained within the document */
@property (nonatomic, strong, readonly) NSArray<OGElement *>* images;

/** Returns @b a elements and @b area elements that have an href within the document */
@property (nonatomic, strong, readonly) NSArray<OGElement *>* links;

/** Returns the head element contained within the document */
@property (nonatomic, strong, readonly, nullable) OGElement *head;

/** Returns the body element contained within the document */
@property (nonatomic, strong, readonly, nullable) OGElement *body;

@end

NS_ASSUME_NONNULL_END
