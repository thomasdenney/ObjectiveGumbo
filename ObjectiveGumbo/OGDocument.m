//
//  OGDocument.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGDocument.h"
#import "OGText.h"
#import "OGNode+OGElementSearch.h"

OGDocumentDocType OGDocTypeFromGumboDocType(GumboQuirksModeEnum quirksMode)
{
    switch(quirksMode) {
        case GUMBO_DOCTYPE_NO_QUIRKS:
            return OGDocumentDocTypeNoQuirks;
            break;
            
        case GUMBO_DOCTYPE_LIMITED_QUIRKS:
            return OGDocumentDocTypeLimitedQuirks;
            break;
            
        case GUMBO_DOCTYPE_QUIRKS:
        default:
            return OGDocumentDocTypeQuirks;
    }
}

NSString* NSStringFromOGDocType(OGDocumentDocType quirksMode)
{
    switch(quirksMode) {
        case OGDocumentDocTypeNoQuirks:
            return @"No Quirks Mode";
            break;
            
        case OGDocumentDocTypeLimitedQuirks:
            return @"Limited Quirks Mode";
            break;
            
        case OGDocumentDocTypeQuirks:
        default:
            return @"Quirks Mode";
    }
}


@interface OGDocument ()

@property (nonatomic, assign) BOOL hasDocType;
@property (nonatomic, assign) BOOL quirksMode;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *systemIdentifier;
@property (nonatomic, copy) NSString *publicIdentifier;

@property (nonatomic, copy, nullable) NSString *title;

@property (nonatomic, strong) NSDictionary<NSString *, OGElement *>* namedMetas;
@property (nonatomic, strong) NSArray<OGElement *>* metas;

@property (nonatomic, strong) NSArray<OGElement *>* anchors;
@property (nonatomic, strong) NSArray<OGElement *>* forms;
@property (nonatomic, strong) NSArray<OGElement *>* images;
@property (nonatomic, strong) NSArray<OGElement *>* links;

@property (nonatomic, strong) OGElement *head;
@property (nonatomic, strong) OGElement *body;

@end


@implementation OGDocument

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.systemIdentifier = @"";
        self.publicIdentifier = @"";
    }
    return self;
}

- (instancetype)initWithGumboNode:(GumboNode *)gumboNode
{
    if (self = [super init]) {
        
        self.hasDocType = (gumboNode->v.document.has_doctype != false);
        self.quirksMode = OGDocTypeFromGumboDocType(gumboNode->v.document.doc_type_quirks_mode);
        
        const char * cName = gumboNode->v.document.name;
        const char * cSystemIdentifier = gumboNode->v.document.system_identifier;
        const char * cPublicIdentifier = gumboNode->v.document.public_identifier;
        
        self.name = [[NSString alloc] initWithUTF8String:cName];
        self.systemIdentifier = [[NSString alloc] initWithUTF8String:cSystemIdentifier];
        self.publicIdentifier = [[NSString alloc] initWithUTF8String:cPublicIdentifier];
    }
    return self;
}

- (NSString *)htmlWithIndentation:(int)indentationLevel
{
    NSMutableString *html = [NSMutableString stringWithFormat:@"<!DOCTYPE %@", self.name];
    if (self.publicIdentifier.length > 0) {
        [html appendFormat:@" \"%@\"", self.publicIdentifier];
    }
    
    if (self.systemIdentifier.length > 0) {
        [html appendFormat:@" \"%@\"", self.systemIdentifier];
    }
    
    [html appendString:@">\n"];
    
    for (OGNode * child in self.children) {
        [html appendString:[child htmlWithIndentation:indentationLevel + 1]];
    }
    return html;
}

- (NSString *)title
{
    if (_title == nil) {
        OGElement *titleTag = self.head[@"title"].firstObject;
        _title = titleTag.text;
    }
    return _title;
}

- (NSArray<NSString *>*)allMetaNames
{
    __block NSMutableSet *allKeys = [NSMutableSet set];
    __block NSMutableArray *nameKeys = [NSMutableArray array];
    
    NSArray<OGElement *> *elements = [self.head elementsWithTag:OGTagMeta attribute:@"name"];
    [elements enumerateObjectsUsingBlock:^(OGElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj.attributes[@"name"];
        
        if(key.length > 0 && ![allKeys containsObject:key]) {
            [nameKeys addObject:key];
            [allKeys addObject:key];
        }
    }];
    
    return nameKeys.copy;
}

- (NSDictionary<NSString *, OGElement *>*)namedMetas
{
    if (_namedMetas == nil) {
        NSArray<OGElement *> *elements = [self.head elementsWithTag:OGTagMeta attribute:@"name"];
        NSMutableDictionary *meta = [[NSMutableDictionary alloc] initWithCapacity:elements.count];
        for (OGElement *metaElement in elements) {
            NSString *name = metaElement.attributes[@"name"];
            
            if (![meta objectForKey:name]) {
                [meta setValue:metaElement forKey:name];
            }
        }
        self.namedMetas = meta.copy;
    }
    return _namedMetas;
}

- (NSArray<OGElement *>*)metas
{
    if (_metas == nil) {
        self.metas = [self.head elementsWithTag:OGTagMeta];
    }
    return _metas;
}

- (NSArray<OGElement *>*)anchors
{
    if (_anchors == nil) {
        self.anchors = [self elementsWithTag:OGTagA attribute:@"name"];
    }
    return _anchors;
}

- (NSArray<OGElement *>*)forms
{
    if (_forms == nil) {
        self.forms = [self elementsWithTag:OGTagForm];
    }
    return _forms;
}

- (NSArray<OGElement *>*)images
{
    if (_images == nil) {
        self.images = [self elementsWithTag:OGTagImg];
    }
    return _images;
}

- (NSArray<OGElement *>*)links
{
    if (_links == nil) {
        self.links = [self elementsContainingLinks];
    }
    return _links;
}

/** Private method that returns @b a or @b area tags that have href attributes on them */
- (NSArray<OGElement *>*)elementsContainingLinks
{
    return (NSArray<OGElement *>*)[self selectWithBlock:^BOOL(id node) {
        if ([node isKindOfClass:[OGElement class]])
        {
            OGElement * element = (OGElement*)node;
            if (element.tag == OGTagA || element.tag == OGTagArea) {
                if (element.attributes[@"href"] != nil) {
                    return YES;
                }
            }
        }
        return NO;
    }];
}

- (OGElement *)head
{
    if (_head == nil) {
        self.head = [[self elementsWithTag:OGTagHead] firstObject];
    }
    return _head;
}

- (OGElement *)body
{
    if (_body == nil) {
        self.body = [[self elementsWithTag:OGTagBody] firstObject];
    }
    return _body;
}

#pragma mark - Debug

- (NSString *)description
{
    NSMutableString *newString = [[NSMutableString alloc] initWithString:@"<<"];
    if (self.hasDocType) {
        [newString appendFormat:@"DocType: %@", self.name];
        if (self.systemIdentifier.length > 0 || self.publicIdentifier.length > 0) {
            [newString appendFormat:@" \"%@\" \"%@\"", self.systemIdentifier, self.publicIdentifier];
        }
    }
    
    [newString appendFormat:@" - %@>>", NSStringFromOGDocType(self.quirksMode)];
    
    NSString *className = NSStringFromClass([self class]);
    return [NSString stringWithFormat:@"<%@: %p %@>", className, self, newString];
}

@end
