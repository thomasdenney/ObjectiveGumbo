// NSString+OG.h
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

@import Foundation;

/**
 Utility methods used in Objective Gumbo for dealing with strings
 */
@interface NSString (OG)

/**
 Inefficiently escapes a string by surrounding it with double quotes ("") and ensures all quotes within the string are also escaped.
 */
- (NSString*)og_escapedString;

/**
 Creates a string that indents characters by 4 spaces * indentation level
 */
+ (NSString*)og_indentationString:(NSUInteger)indentationLevel;

@end
