//
//  OGText.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGText.h"

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
        if (self.isWhitespace) {
            return @"  ";
        } else {
            return _text;
        }
    } else {
        return @"";
    }
}

#pragma mark - Debugging

- (NSString *)description
{
    NSString *className = NSStringFromClass([self class]);
    return [NSString stringWithFormat:@"<%@: %p \"%@\">", className, self, self.text];
}

- (NSString *)htmlWithIndentation:(int)indentationLevel
{
    self.text = [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.isText)
    {
        if ([self.text hasSuffix:@"\n"]) return self.text;
        return [NSString stringWithFormat:@"%@\n", self.text];
    }
    else if (self.isComment)
    {
        return [NSString stringWithFormat:@"<!--%@-->\n", self.text];
    }
    return [NSString indentationString:indentationLevel];
}

@end

@implementation OGComment
@end

@implementation OGCDataSection
@end
