//
//  OGDocument.h
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas, 2017 Richard Warrender. All rights reserved.
//

#import "OGNode.h"
#import "OGElement.h"

NS_ASSUME_NONNULL_BEGIN

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


@interface OGDocument : OGElement

/** Indicates document has provided a doc type and it isn't automatically inferred */
@property (nonatomic, assign, readonly) BOOL hasDocType;

/** Shortcut for seeing if quirks mode should be enabled */
@property (nonatomic, assign, readonly) BOOL quirksMode;

/** The doctype name. This will usually be HTML */
@property (nonatomic, copy, readonly) NSString *name;

/** Returns @b title element value as a string from the head tag */
@property (nonatomic, copy, readonly, nullable) NSString *title;

/** Doctype Public identifier if one is specified */
@property (nonatomic, copy, readonly) NSString *publicIdentifier;

/** Doctype Public identifier if one is specified */
@property (nonatomic, copy, readonly) NSString *systemIdentifier;

/** Returns an array of name keys for use in looking up @b namedMetaData */
@property (nonatomic, strong, readonly) NSArray<NSString *>* allMetaNames;

/** Return a dictionary of @b meta elements with attribute names as the keys that are contained within the document. Note that in the case of meta tags with duplicate names, only the first will be present */
@property (nonatomic, strong, readonly) NSDictionary<NSString *, OGElement *>* namedMetas;

/** Returns @b meta elements that have name attributes contained within the document */
@property (nonatomic, strong, readonly) NSArray<OGElement *>* metas;

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
