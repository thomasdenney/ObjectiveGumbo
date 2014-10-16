// OGText.m
//
// Copyright 2014 Programming Thomas
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

-(NSString*)htmlWithIndentation:(int)indentationLevel
{
    _text = [_text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.isText)
    {
        if ([_text hasSuffix:@"\n"]) return _text;
        return [NSString stringWithFormat:@"%@\n", _text];
    }
    else if (self.isComment)
    {
        return [NSString stringWithFormat:@"<!--%@-->\n", _text];
    }
    return [NSString indentationString:indentationLevel];
}

@end
