//
//  OGText.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGText.h"

@interface OGText ()

@property (nonatomic, copy) NSString *text;

@end

@implementation OGText

-(id)initWithText:(NSString *)text andType:(GumboNodeType)type
{
    self = [super init];
    if (self)
    {
        self.text = text;
        self.isText = type == GUMBO_NODE_TEXT;
        self.isWhitespace = type == GUMBO_NODE_WHITESPACE;
        self.isComment = type == GUMBO_NODE_COMMENT;
        self.isCData = type == GUMBO_NODE_CDATA;
    }
    return self;
}

-(NSString*)text
{
    if (self.isText)
    {
        return self.text;
    }
    else
    {
        return @"";
    }
}

-(NSString*)htmlWithIndentation:(int)indentationLevel
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
