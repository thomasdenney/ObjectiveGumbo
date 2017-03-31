//
//  ObjectiveGumbo.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "ObjectiveGumbo.h"
#import "OGNodeProtected.h"
#import "OGError.h"
#import "error.h"

typedef NS_OPTIONS(NSUInteger, OGParseOptions) {
    OGParseOptionsParseUseRootNode = 1 << 0, /* If set, ignore the document node and skip straight to next root node */
};

@interface ObjectiveGumboInternal : NSObject

- (instancetype)initWithString:(NSString *)string;

- (instancetype)initWithData:(NSData *)data
                    encoding:(NSStringEncoding)enc;

- (BOOL)parseWithOptions:(OGParseOptions)options;

@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) OGDocument *documentNode;
@property (nonatomic, strong) OGNode *rootNode;
@property (nonatomic, strong) NSError *parseError;
@end


@implementation ObjectiveGumboInternal

- (instancetype)initWithString:(NSString *)string
{
    if (self = [super init]) {
        self.string = string;
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data encoding:(NSStringEncoding)enc
{
    if (self = [super init]) {
        self.string = [[NSString alloc] initWithData:data encoding:enc];
    }
    return self;
}

- (BOOL)parseWithOptions:(OGParseOptions)options
{
    self.documentNode = nil;
    self.rootNode = nil;
    self.parseError = nil;
    
    if ((self.string == nil) || self.string.length == 0) {
        NSError *error = [NSError errorWithDomain:OGErrorDomain
                                             code:OGErrorNoContent
                                         userInfo:@{NSLocalizedDescriptionKey: @"Data is empty or doesn't exist so there is nothing to parse"}];
        
        self.parseError = error;
        return NO;
    }
    
    if (![self.string canBeConvertedToEncoding:NSUTF8StringEncoding]) {
        NSError *error = [NSError errorWithDomain:OGErrorDomain
                                             code:OGErrorNotUTF8Compatible
                                         userInfo:@{NSLocalizedDescriptionKey: @"Text cannot be converted to UTF-8 without data loss."}];
        
        self.parseError = error;
        return NO;
    }

    GumboOutput *output = gumbo_parse(self.string.UTF8String);
    
    if (output->errors.length != 0) {
        int error_count = output->errors.length;
        
        NSMutableArray *errorObjects = [NSMutableArray arrayWithCapacity:error_count];
        for (int i = 0; i < error_count; i++) {
            
            GumboError *gumbo_error = output->errors.data[i];
            if (gumbo_error->type == GUMBO_ERR_PARSER) {
                GumboParserError gumbo_parse_error = gumbo_error->v.parser;
                
                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                OGErrorPosition position = {gumbo_error->position.line, gumbo_error->position.column, gumbo_error->position.offset};
                
                [userInfo setValue:@"Cannot parse HTML" forKey:NSLocalizedDescriptionKey];
                
                OGParseError *parseError = [OGParseError errorWithDomain:OGErrorDomain
                                                                code:OGErrorParser
                                                            position:position
                                                            userInfo:userInfo.copy];
                
                [errorObjects addObject:parseError];
            }
        }
        
        NSDictionary *userInfo = @{NSUnderlyingErrorKey: errorObjects};
        self.parseError = [NSError errorWithDomain:OGErrorDomain code:OGErrorParser userInfo:userInfo];
    }

    BOOL useRoot = options & OGParseOptionsParseUseRootNode;
    GumboNode *gumboNode = (useRoot ? output->root : output->document);
    
    if (gumboNode->v.element.tag == GUMBO_TAG_UNKNOWN) {
        return NO;
    }
    
    OGNode *node = [self objectiveGumboNodeFromGumboNode:gumboNode];
    gumbo_destroy_output(&kGumboDefaultOptions, output);
    
    self.rootNode = (useRoot ? node : [node.children firstObject]);
    
    return YES;
}

- (OGNode *)objectiveGumboNodeFromGumboNode:(GumboNode *)gumboNode
{
    OGNode * node;
    if (gumboNode->type == GUMBO_NODE_DOCUMENT)
    {
        OGDocument *documentNode = [[OGDocument alloc] initWithGumboNode:gumboNode];
        self.documentNode = documentNode;
        GumboVector * cChildren = &gumboNode->v.document.children;
        documentNode.children = [self arrayOfObjectiveGumboNodesFromGumboVector:cChildren andParent:documentNode];
        
        node = documentNode;
    }
    else if (gumboNode->type == GUMBO_NODE_ELEMENT)
    {
        OGElement * elementNode = [[OGElement alloc] initWithGumboNode:gumboNode];
        GumboVector * cChildren = &gumboNode->v.element.children;
        elementNode.children = [self arrayOfObjectiveGumboNodesFromGumboVector:cChildren andParent:elementNode];
        elementNode.ownerDocument = self.documentNode;
        
        node = elementNode;
    }
    else
    {
        const char *cText = gumboNode->v.text.text;
        NSString *text = [[NSString alloc] initWithUTF8String:cText];
        
        node = [OGText textNodeWithText:text andType:gumboNode->type];
        node.ownerDocument = self.documentNode;
    }
    
    return node;
}

- (NSArray *)arrayOfObjectiveGumboNodesFromGumboVector:(GumboVector*)cChildren andParent:(OGNode*)parent
{
    NSMutableArray *children = [NSMutableArray new];
    
    OGNode *previousSibling = nil;
    for (int i = 0; i < cChildren->length; i++)
    {
        OGNode * childNode = [self objectiveGumboNodeFromGumboNode:cChildren->data[i]];
        
        if ([childNode isKindOfClass:[OGText class]]) {
            OGText *textNode = (OGText *)childNode;
            if (textNode.isWhitespace) {
                continue;
            }
        }
        
        childNode.parent = parent;
        childNode.previousSibling = previousSibling;
        [children addObject:childNode];
        
        previousSibling.nextSibling = childNode;
        previousSibling = childNode;
    }
    
    return children;
}

@end


@implementation ObjectiveGumbo

#pragma mark - Private internal methods
//* For returning two types of nodes from the internal gumbo object */

+ (nullable OGNode *)documentFromGumboInternal:(ObjectiveGumboInternal *)gumbo error:(NSError **)error
{
    BOOL success = [gumbo parseWithOptions:0];
    if (success) {
        return gumbo.documentNode;
    } else {
        if (error != nil) {
            *error = gumbo.parseError;
        }
        return nil;
    }
}

+ (nullable OGNode *)nodeFromGumboInternal:(ObjectiveGumboInternal *)gumbo error:(NSError **)error
{
    BOOL success = [gumbo parseWithOptions:OGParseOptionsParseUseRootNode];
    if (success) {
        return gumbo.rootNode;
    } else {
        if (error != nil) {
            *error = gumbo.parseError;
        }
        return nil;
    }
}

#pragma mark - Class method initialisers

+ (nullable OGDocument *)documentWithData:(NSData *)data
                                 encoding:(NSStringEncoding)enc
                                    error:(NSError **)error
{
    ObjectiveGumboInternal *gumbo = [[ObjectiveGumboInternal alloc] initWithData:data encoding:enc];
    return [ObjectiveGumbo documentFromGumboInternal:gumbo error:error];
}

+ (nullable OGNode *)nodeWithData:(NSData *)data
                         encoding:(NSStringEncoding)enc
                            error:(NSError **)error
{
    ObjectiveGumboInternal *gumbo = [[ObjectiveGumboInternal alloc] initWithData:data encoding:enc];
    return [ObjectiveGumbo nodeFromGumboInternal:gumbo error:error];
}

+ (nullable OGDocument *)documentWithString:(NSString *)string
                                      error:(NSError **)error
{
    ObjectiveGumboInternal *gumbo = [[ObjectiveGumboInternal alloc] initWithString:string];
    return [ObjectiveGumbo documentFromGumboInternal:gumbo error:error];
}

+ (nullable OGNode *)nodeWithString:(NSString *)string
                              error:(NSError **)error
{
    ObjectiveGumboInternal *gumbo = [[ObjectiveGumboInternal alloc] initWithString:string];
    return [ObjectiveGumbo nodeFromGumboInternal:gumbo error:error];
}

+ (nullable OGDocument *)documentWithURL:(NSURL *)url
                                encoding:(NSStringEncoding)enc
                                   error:(NSError **)error
{
    NSString *string = [[NSString alloc] initWithContentsOfURL:url encoding:enc error:error];
    if (string) {
        ObjectiveGumboInternal *gumbo = [[ObjectiveGumboInternal alloc] initWithString:string];
        return [ObjectiveGumbo documentFromGumboInternal:gumbo error:error];
    } else {
        return nil;
    }
}

+ (nullable OGNode *)nodeWithURL:(NSURL *)url
                        encoding:(NSStringEncoding)enc
                           error:(NSError **)error
{
    NSString *string = [[NSString alloc] initWithContentsOfURL:url encoding:enc error:error];
    if (string) {
        ObjectiveGumboInternal *gumbo = [[ObjectiveGumboInternal alloc] initWithString:string];
        return [self nodeFromGumboInternal:gumbo error:error];
    } else {
        return nil;
    }
}

@end
