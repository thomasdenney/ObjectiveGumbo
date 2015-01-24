// ObjectiveGumbo.m
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

#import "ObjectiveGumbo.h"
#import "_OGMutableElement.h"
#import "_OGMutableNode.h"

#import "gumbo.h"

@implementation ObjectiveGumbo

+ (OGNode*)parseNodeWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [ObjectiveGumbo parseNodeWithString:string];
}

+ (OGNode*)parseNodeWithString:(NSString *)string {
    if (!string.length) {
        return nil;
    }
    GumboOutput * output = [ObjectiveGumbo outputFromString:string];
    OGNode * node = [ObjectiveGumbo objectiveGumboNodeFromGumboNode:output->root];
    gumbo_destroy_output(&kGumboDefaultOptions, output);
    return node;
}

+ (OGDocument*)parseDocumentWithUrl:(NSURL *)url encoding:(NSStringEncoding)enc {
    if (!url) {
        return nil;
    }
    //TODO: Remove this method once deprecation is complete
    NSError * error;
    NSString * string = [[NSString alloc] initWithContentsOfURL:url encoding:enc error:&error];
    if (!error) {
        return [ObjectiveGumbo parseDocumentWithString:string];
    }
    return nil;
}

+ (OGDocument*)parseDocumentWithData:(NSData *)data encoding:(NSStringEncoding)enc {
    if (!data) {
        return nil;
    }
    NSString * string = [[NSString alloc] initWithData:data encoding:enc];
    return [ObjectiveGumbo parseDocumentWithString:string];
}

+ (OGDocument*)parseDocumentWithString:(NSString *)string {
    if (!string) {
        return nil;
    }
    GumboOutput * output = [ObjectiveGumbo outputFromString:string];
    OGDocument * node = (OGDocument*)[ObjectiveGumbo objectiveGumboNodeFromGumboNode:output->document];
    gumbo_destroy_output(&kGumboDefaultOptions, output);
    return node;
}

+ (GumboOutput*)outputFromString:(NSString*)string {
    return gumbo_parse(string.UTF8String);
}

+ (OGNode*)objectiveGumboNodeFromGumboNode:(GumboNode*)gumboNode {
    if (gumboNode->type == GUMBO_NODE_DOCUMENT) {
        const char * cName = gumboNode->v.document.name;
        const char * cPublicIdentifier = gumboNode->v.document.public_identifier;
        const char * cSystemIdentifier = gumboNode->v.document.system_identifier;
        
        NSString * name = [NSString stringWithUTF8String:cName];
        NSString * publicID = [NSString stringWithUTF8String:cPublicIdentifier];
        NSString * systemID = [NSString stringWithUTF8String:cSystemIdentifier];
        
        OGDocument * documentNode = [[OGDocument alloc] initWithName:name publicID:publicID systemID:systemID];
        
        GumboVector * cChildren = &gumboNode->v.document.children;
        documentNode.children = [ObjectiveGumbo arrayOfObjectiveGumboNodesFromGumboVector:cChildren andParent:documentNode];
        
        return documentNode;
    }
    else if (gumboNode->type == GUMBO_NODE_ELEMENT) {
        OGElement * elementNode = [OGElement new];
        
        elementNode.tag = (OGTag)gumboNode->v.element.tag;
        elementNode.tagNamespace = (OGNamespace)gumboNode->v.element.tag_namespace;
        
        NSMutableDictionary * attributes = [[NSMutableDictionary alloc] init];
        
        GumboVector * cAttributes = &gumboNode->v.element.attributes;
        
        for (unsigned int i = 0; i < cAttributes->length; i++) {
            GumboAttribute * cAttribute = (GumboAttribute*)cAttributes->data[i];
            
            const char * cName = cAttribute->name;
            const char * cValue = cAttribute->value;
            
            NSString * name = [[NSString alloc] initWithUTF8String:cName];
            NSString * value = [[NSString alloc] initWithUTF8String:cValue];
            
            attributes[name] = value;
            
            if ([name isEqualToString:@"class"]) {
                elementNode.classes = [value componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
        }
        
        elementNode.attributes = attributes;
        
        GumboVector * cChildren = &gumboNode->v.element.children;
        elementNode.children = [ObjectiveGumbo arrayOfObjectiveGumboNodesFromGumboVector:cChildren andParent:elementNode];
        
        return elementNode;
    }
    else if (gumboNode->type == GUMBO_NODE_TEXT || gumboNode->type == GUMBO_NODE_CDATA || gumboNode->type == GUMBO_NODE_COMMENT || gumboNode->type == GUMBO_NODE_WHITESPACE) {
        const char * cText = gumboNode->v.text.text;
        NSString * text = [[NSString alloc] initWithUTF8String:cText];
        return [[OGText alloc] initWithText:text type:(OGNodeType)gumboNode->type];
    }
    return nil;
}

+ (NSArray*)arrayOfObjectiveGumboNodesFromGumboVector:(GumboVector*)cChildren andParent:(OGNode*)parent {
    NSMutableArray * children = [NSMutableArray new];
    
    for (unsigned int i = 0; i < cChildren->length; i++) {
        OGNode * childNode = [ObjectiveGumbo objectiveGumboNodeFromGumboNode:cChildren->data[i]];
        if (childNode) {
            childNode.parent = (OGElement*)parent;
            [children addObject:childNode];
        }
    }
    
    NSAssert(cChildren->length == children.count, @"Failed to parse children of node");
    
    return children;
}

@end
