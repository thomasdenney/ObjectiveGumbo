//
//  OGText.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGText.h"

@implementation OGText

-(id)initWithText:(NSString *)text andType:(GumboNodeType)type
{
    self = [super init];
    if (self)
    {
        _text = text;
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
        return _text;
    }
    else
    {
        return @"";
    }
}

@end
