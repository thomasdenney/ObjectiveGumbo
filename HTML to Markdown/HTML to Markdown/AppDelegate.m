//
//  AppDelegate.m
//  HTML to Markdown
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)convert:(id)sender
{
    OGNode * element = [ObjectiveGumbo parseNodeWithString:self.htmlField.stringValue];
    self.markdownField.stringValue = [NSString stringWithFormat:@"%@\n\n%@", [self markdownFromNode:element], [element html]];
}

-(NSString*)markdownFromNode:(OGNode*)node
{
    if ([node isKindOfClass:[OGText class]])
    {
        return node.text;
    }
    else if ([node isKindOfClass:[OGElement class]])
    {
        OGElement * element = (OGElement*)node;
        NSMutableString * childMarkdown = [NSMutableString new];
        for (OGNode * child in element.children)
        {
            [childMarkdown appendString:[self markdownFromNode:child]];
        }
        if (element.tag == GUMBO_TAG_EM || element.tag == GUMBO_TAG_I)
        {
            return [NSString stringWithFormat:@"*%@*", childMarkdown];
        }
        else if (element.tag == GUMBO_TAG_B)
        {
            return [NSString stringWithFormat:@"**%@**", childMarkdown];
        }
        else if (element.tag == GUMBO_TAG_A)
        {
            return [NSString stringWithFormat:@"[%@](%@)", childMarkdown, element.attributes[@"href"]];
        }
        else
        {
            return childMarkdown;
        }
    }
    else if ([node isKindOfClass:[OGDocument class]])
    {
        OGDocument * element = (OGDocument*)node;
        NSMutableString * childMarkdown = [NSMutableString new];
        for (OGNode * child in element.children)
        {
            [childMarkdown appendString:[self markdownFromNode:child]];
        }
        return childMarkdown;
    }
    return @"";
}

@end
