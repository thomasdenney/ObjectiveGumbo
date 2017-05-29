//
//  OGTags.m
//  ObjectiveGumbo
//
//  Copyright (c) 2017 Richard Warrender. All rights reserved.
//
//

#import "OGTags.h"
#import "gumbo.h"

NSString* NSStringFromOGTag(OGTag tag)
{
    GumboTag gumbo_tag = (GumboTag)tag;
    const char* tag_cString = gumbo_normalized_tagname(gumbo_tag);
    return [NSString stringWithCString:tag_cString encoding:NSUTF8StringEncoding];
}

OGTag OGTagFromNSString(NSString *string)
{
    if (string.length > 0) {
        const char *tag_cString = string.UTF8String;
        GumboTag gumbo_tag = gumbo_tag_enum(tag_cString);
        return (OGTag)gumbo_tag;
    }
    return OGTagUnknown;
}

