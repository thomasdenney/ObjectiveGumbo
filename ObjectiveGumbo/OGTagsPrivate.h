//
//  OGTagsPrivate.h
//  ObjectiveGumbo
//
//  Copyright (c) 2017 Richard Warrender. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "OGTags.h"
#import "gumbo.h"

NS_INLINE OGNamespace OGNamespaceFromGumboNamespace(GumboNamespaceEnum g_namespace)
{
    return (OGNamespace)g_namespace;
}

NS_INLINE GumboNamespaceEnum GumboNamespaceFromOGNamespace(OGNamespace og_namespace) {
    return (GumboNamespaceEnum)og_namespace;
}

NS_INLINE OGTag OGTagFromGumboTag(GumboTag gumbo_tag)
{
    
    assert(gumbo_tag <= OGTagUnknown); // GumboTag enum is outside of range of OGTag
    return (OGTag)gumbo_tag;
}

NS_INLINE GumboTag GumboTagFromOGTag(OGTag tag)
{
    assert(tag <= OGTagUnknown); // GumboTag enum is outside of range of OGTag
    return (GumboTag)tag;
}
