//
//  OGElement.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGElement.h"
#import "OGText.h"
#import "OGNode+OGElementSearch.h"
#import "OGTagsPrivate.h"

@interface OGElement ()

@property (nonatomic, assign) OGTag tag;
@property (nonatomic, assign) OGNamespace tagNamespace;

@property (nonatomic, strong) NSArray *classes;
@property (nonatomic, strong) NSDictionary *attributes;

@end


@implementation OGElement

- (instancetype)initWithGumboNode:(GumboNode *)gumboNode
{
    if (self = [super init]) {
        self.tag = OGTagFromGumboTag(gumboNode->v.element.tag);
        self.tagNamespace = OGNamespaceFromGumboNamespace(gumboNode->v.element.tag_namespace);
        
        NSMutableDictionary * attributes = [[NSMutableDictionary alloc] init];
        GumboVector * cAttributes = &gumboNode->v.element.attributes;
        
        for (int i = 0; i < cAttributes->length; i++)
        {
            GumboAttribute *cAttribute = (GumboAttribute*)cAttributes->data[i];
            
            const char *cName = cAttribute->name;
            const char *cValue = cAttribute->value;
            
            NSString *name = [[NSString alloc] initWithUTF8String:cName];
            NSString *value = [[NSString alloc] initWithUTF8String:cValue];
            
            [attributes setValue:value forKey:name];
            
            if ([name isEqualToString:@"class"]) {
                self.classes = [value componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
        }
        
        self.attributes = attributes;
    }
    return self;
}

- (NSString *)text
{
    NSMutableString * text = [NSMutableString new];
    for (OGNode *child in self.children)
    {
        [text appendString:child.text];
    }
    return text;
}

- (nullable OGNode *)selectFirstWithBlock:(SelectorBlock)block
{
    for (OGNode *child in self.children)
    {
        if (block(child)) {
            return child;
        } else {
            return [[child selectWithBlock:block] firstObject];
        }
    }
    return nil;
}

- (NSArray<OGNode *> *)selectWithBlock:(SelectorBlock)block
{
    NSMutableArray * matchingChildren = [NSMutableArray new];
    for (OGNode * child in self.children)
    {
        if (block(child))
        {
            [matchingChildren addObject:child];
        }
        [matchingChildren addObjectsFromArray:[child selectWithBlock:block]];
    }
    return matchingChildren;
}

#pragma mark - Debugging

- (NSString *)htmlWithIndentation:(int)indentationLevel
{
    NSMutableString *html = [NSMutableString stringWithFormat:@"<%@", NSStringFromOGTag(self.tag)];
    for (NSString *attribute in self.attributes)
    {
        [html appendFormat:@" %@=\"%@\"", attribute, [self.attributes[attribute]  escapedString]];
    }
    if (self.children.count == 0)
    {
        [html appendString:@" />"];
    }
    else
    {
        [html appendString:@">"];
        for (OGNode *child in self.children)
        {
            if ([child isKindOfClass:[OGText class]]) {
                [html appendString:child.html];
            } else {
                [html appendString:[child htmlWithIndentation:indentationLevel + 1]];
            }
        }
        [html appendFormat:@"</%@>", NSStringFromOGTag(self.tag)];
    }
    return html;
}

- (BOOL)hasClassNamed:(NSString *)className
{
    return [self.classes containsObject:className];
}

- (NSString *)description
{
    NSString *className = NSStringFromClass([self class]);
    NSMutableString *newString = [[NSMutableString alloc] init];
    [newString appendFormat:@"<%@: %p %@", className, self, NSStringFromOGTag(self.tag)];
    
    NSString *elementID = self.attributes[@"id"];
    if (elementID.length > 0) {
        [newString appendFormat:@"#%@", elementID];
    }
    
    if (self.classes.count > 0) {
        for (NSString *className in self.classes) {
            [newString appendFormat:@".%@", className];
        }
    }
    [newString appendString:@">"];
         
    return newString;
}

@end
