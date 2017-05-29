//
//  NSString+OGString.m
//  Hacker News
//
//  Created by Thomas Denney on 30/08/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "NSString+OGString.h"

@implementation NSString (OGString)

- (NSString*)escapedString
{
    NSString *escapedString = [self stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    return escapedString;
}

+ (NSString *)indentationString:(int)indentationLevel
{
    return @"";
}

@end
