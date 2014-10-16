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

@interface OGText () {
    NSString * _text;
}

@end

@implementation OGText

- (instancetype)initWithText:(NSString *)text type:(OGNodeType)type {
    self = [super init];
    if (self) {
        _isText = type == OGNodeTypeText;
        _isWhitespace = type == OGNodeTypeWhitespace;
        _isComment = type == OGNodeTypeComment;
        _isCData = type == OGNodeTypeCData;
        NSAssert(_isText || _isWhitespace || _isComment || _isCData, @"Attempt to instantiate a text node with a non-text node type");
        _text = text;
    }
    return self;
}

- (NSString*)text {
    //TODO: Support returning the actual text of a comment or whitespace...
    if (self.isText) {
        return _text;
    }
    else {
        return @"";
    }
}

- (NSString*)htmlWithIndentation:(int)indentationLevel {
    _text = [_text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.isText) {
        if ([_text hasSuffix:@"\n"]) {
            return _text;
        }
        return [NSString stringWithFormat:@"%@\n", _text];
    }
    else if (self.isComment) {
        //TODO: String escaping?
        return [NSString stringWithFormat:@"<!--%@-->\n", _text];
    }
    return [NSString og_indentationString:indentationLevel];
}

@end
