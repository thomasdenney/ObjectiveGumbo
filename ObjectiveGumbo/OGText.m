//
//  OGText.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGText.h"
#import "OGTags.h"

@interface OGText ()

@property (nonatomic, assign) BOOL isComment;
@property (nonatomic, assign) BOOL isCData;
@property (nonatomic, assign) BOOL isWhitespace;
@property (nonatomic, assign) BOOL isText;

@property (nonatomic, copy) NSString *text;

- (instancetype)initWithText:(NSString*)text andType:(GumboNodeType)type;

@end


@implementation OGText

@synthesize text = _text;

+ (instancetype)textNodeWithText:(NSString *)text andType:(GumboNodeType)type
{
    OGText *node = nil;
    switch (type) {
        case GUMBO_NODE_CDATA: {
            node = [[OGComment alloc] initWithText:text andType:type];
        }
        break;
        case GUMBO_NODE_COMMENT:
        {
            node = [[OGComment alloc] initWithText:text andType:type];
        }
        break;
            
        default: {
            node = [[OGText alloc] initWithText:text andType:type];
        }
        break;
    }
    return node;
}

- (instancetype)initWithText:(NSString *)text andType:(GumboNodeType)type
{
    if (self = [super init]) {
        self.text = text;
        self.isText = type == GUMBO_NODE_TEXT;
        self.isWhitespace = type == GUMBO_NODE_WHITESPACE;
        self.isComment = type == GUMBO_NODE_COMMENT;
        self.isCData = type == GUMBO_NODE_CDATA;
    }
    return self;
}

- (NSString *)text
{
    if (_text.length > 0) {
        return _text;
    } else {
        return @"";
    }
}

#pragma mark - Debugging

- (NSString *)description
{
    NSString *debugText = _text;
    if (debugText.length > 0) {
        if (self.isWhitespace) {
            debugText = [debugText stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
            debugText = [debugText stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
            debugText = [debugText stringByReplacingOccurrencesOfString:@" " withString:@"\\w"];
        }
    }
    
    NSString *className = NSStringFromClass([self class]);
    return [NSString stringWithFormat:@"<%@: %p \"%@\">", className, self, debugText];
}

- (NSString *)htmlWithIndentation:(int)indentationLevel
{
    if (self.isComment)
    {
        return [NSString stringWithFormat:@"<!--%@-->", self.text];
    }
    else if (self.isWhitespace)
    {
        return @"";
    }
    else if (self.isText)
    {
        return [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    else
    {
        return self.text;
    }
}

@end

@implementation OGComment
@end

@implementation OGCDataSection
@end
