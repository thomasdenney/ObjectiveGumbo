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
#import "gumbo.h"

@implementation ObjectiveGumbo

+(OGNode*)parseNodeWithData:(NSData *)data
{
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [ObjectiveGumbo parseNodeWithString:string];
}

+(OGNode*)parseNodeWithString:(NSString *)string
{
    GumboOutput * output = [ObjectiveGumbo outputFromString:string];
    OGNode * node = [ObjectiveGumbo objectiveGumboNodeFromGumboNode:output->root];
    gumbo_destroy_output(&kGumboDefaultOptions, output);
    return node;
}

+(OGDocument*)parseDocumentWithUrl:(NSURL *)url encoding:(NSStringEncoding)enc
{
    NSError * error;
    NSString * string = [[NSString alloc] initWithContentsOfURL:url encoding:enc error:&error];
    if (error == nil)
    {
        return [ObjectiveGumbo parseDocumentWithString:string];
    }
    else
    {
        return nil;
    }
}

+(OGDocument*)parseDocumentWithData:(NSData *)data encoding:(NSStringEncoding)enc
{
    NSString * string = [[NSString alloc] initWithData:data encoding:enc];
    return [ObjectiveGumbo parseDocumentWithString:string];
}

+(OGDocument*)parseDocumentWithString:(NSString *)string
{
    GumboOutput * output = [ObjectiveGumbo outputFromString:string];
    OGDocument * node = (OGDocument*)[ObjectiveGumbo objectiveGumboNodeFromGumboNode:output->document];
    gumbo_destroy_output(&kGumboDefaultOptions, output);
    return node;
}

+(GumboOutput*)outputFromString:(NSString*)string
{
    GumboOutput * output = gumbo_parse(string.UTF8String);
    return output;
}

+(OGNode*)objectiveGumboNodeFromGumboNode:(GumboNode*)gumboNode
{
    OGNode * node;
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
        
        node = documentNode;
    }
    else if (gumboNode->type == GUMBO_NODE_ELEMENT)
    {
        OGElement * elementNode = [[OGElement alloc] init];
        
        elementNode.tag = (OGTag)gumboNode->v.element.tag;
        elementNode.tagNamespace = (OGNamespace)gumboNode->v.element.tag_namespace;
        
        NSMutableDictionary * attributes = [[NSMutableDictionary alloc] init];
        
        GumboVector * cAttributes = &gumboNode->v.element.attributes;
        
        for (int i = 0; i < cAttributes->length; i++)
        {
            GumboAttribute * cAttribute = (GumboAttribute*)cAttributes->data[i];
            
            const char * cName = cAttribute->name;
            const char * cValue = cAttribute->value;
            
            NSString * name = [[NSString alloc] initWithUTF8String:cName];
            NSString * value = [[NSString alloc] initWithUTF8String:cValue];
            
            [attributes setValue:value forKey:name];
            
            if ([name isEqualToString:@"class"])
            {
                elementNode.classes = [value componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
        }
        
        elementNode.attributes = attributes;
        
        GumboVector * cChildren = &gumboNode->v.element.children;
        elementNode.children = [ObjectiveGumbo arrayOfObjectiveGumboNodesFromGumboVector:cChildren andParent:elementNode];
        
        node = elementNode;
    }
    else
    {
        const char * cText = gumboNode->v.text.text;
        NSString * text = [[NSString alloc] initWithUTF8String:cText];
        node = [[OGText alloc] initWithText:text andType:gumboNode->type];
        node = nil;
    }
    
    return node;
}

+(NSArray*)arrayOfObjectiveGumboNodesFromGumboVector:(GumboVector*)cChildren andParent:(OGNode*)parent
{
    NSMutableArray * children = [NSMutableArray new];
    
    for (int i = 0; i < cChildren->length; i++)
    {
        OGNode * childNode = [ObjectiveGumbo objectiveGumboNodeFromGumboNode:cChildren->data[i]];
        childNode.parent = parent;
        [children addObject:childNode];
    }
    
    return children;
}

@end
