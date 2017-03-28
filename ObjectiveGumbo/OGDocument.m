//
//  OGDocument.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGDocument.h"
#import "OGText.h"

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
