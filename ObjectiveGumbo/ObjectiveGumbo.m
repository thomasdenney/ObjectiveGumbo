//
//  ObjectiveGumbo.m
//  ObjectiveGumbo
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "ObjectiveGumbo.h"
#import "OGNodeProtected.h"

@implementation ObjectiveGumbo

+ (OGNode *)parseNodeWithUrl:(NSURL *)url encoding:(NSStringEncoding)enc
{
    NSError *error = nil;
    NSString *string = [[NSString alloc] initWithContentsOfURL:url encoding:enc error:&error];
    if (error == nil)
    {
        return [ObjectiveGumbo parseNodeWithString:string];
    }
    else
    {
        return nil;
    }
}

+ (OGNode *)parseNodeWithData:(NSData *)data
{
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [ObjectiveGumbo parseNodeWithString:string];
}

+ (OGNode *)parseNodeWithString:(NSString *)string
{
    GumboOutput *output = [ObjectiveGumbo outputFromString:string];
    OGNode *node = [ObjectiveGumbo objectiveGumboNodeFromGumboNode:output->root];
    gumbo_destroy_output(&kGumboDefaultOptions, output);
    return node;
}

+ (OGDocument *)parseDocumentWithUrl:(NSURL *)url encoding:(NSStringEncoding)enc
{
    NSError *error = nil;
    NSString *string = [[NSString alloc] initWithContentsOfURL:url encoding:enc error:&error];
    if (error == nil)
    {
        return [ObjectiveGumbo parseDocumentWithString:string];
    }
    else
    {
        return nil;
    }
}

+ (OGDocument *)parseDocumentWithData:(NSData *)data encoding:(NSStringEncoding)enc
{
    NSString * string = [[NSString alloc] initWithData:data encoding:enc];
    return [ObjectiveGumbo parseDocumentWithString:string];
}

+ (OGDocument *)parseDocumentWithString:(NSString *)string
{
    GumboOutput * output = [ObjectiveGumbo outputFromString:string];
    OGDocument * node = (OGDocument*)[ObjectiveGumbo objectiveGumboNodeFromGumboNode:output->document];
    gumbo_destroy_output(&kGumboDefaultOptions, output);
    return node;
}

+ (GumboOutput *)outputFromString:(NSString*)string
{
    GumboOutput * output = gumbo_parse(string.UTF8String);
    return output;
}

+ (OGNode *)objectiveGumboNodeFromGumboNode:(GumboNode*)gumboNode
{
    OGNode * node;
    if (gumboNode->type == GUMBO_NODE_DOCUMENT)
    {
        OGDocument * documentNode = [[OGDocument alloc] initWithGumboNode:gumboNode];
        GumboVector * cChildren = &gumboNode->v.document.children;
        documentNode.children = [ObjectiveGumbo arrayOfObjectiveGumboNodesFromGumboVector:cChildren andParent:documentNode];
        
        node = documentNode;
    }
    else if (gumboNode->type == GUMBO_NODE_ELEMENT)
    {
        OGElement * elementNode = [[OGElement alloc] initWithGumboNode:gumboNode];
        GumboVector * cChildren = &gumboNode->v.element.children;
        elementNode.children = [ObjectiveGumbo arrayOfObjectiveGumboNodesFromGumboVector:cChildren andParent:elementNode];
        
        node = elementNode;
    }
    else
    {
        const char * cText = gumboNode->v.text.text;
        NSString * text = [[NSString alloc] initWithUTF8String:cText];
        
        node = [OGText textNodeWithText:text andType:gumboNode->type];
    }
    
    return node;
}

+ (NSArray *)arrayOfObjectiveGumboNodesFromGumboVector:(GumboVector*)cChildren andParent:(OGNode*)parent
{
    NSMutableArray * children = [NSMutableArray new];
    
    OGNode *previousSibling = nil;
    for (int i = 0; i < cChildren->length; i++)
    {
        OGNode * childNode = [ObjectiveGumbo objectiveGumboNodeFromGumboNode:cChildren->data[i]];
        childNode.parent = parent;
        childNode.previousSibling = previousSibling;
        [children addObject:childNode];
        
        previousSibling.nextSibling = childNode;
        previousSibling = childNode;
    }
    
    return children;
}

@end
