//
//  main.m
//  OGDemo
//
//  Created by Thomas Denney on 16/10/2014.
//  Copyright (c) 2014 Programming Thomas. All rights reserved.
//

@import Foundation;
@import ObjectiveGumbo;

NSString * const simpleHTML = @""
"<!DOCTYPE html>"
"<html>"
"<head><title>This is a simple demo page!</title></head>"
"<body>"
"<h1>A header</h1>"
"</body>"
"</html>";

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        OGDocument * document = [ObjectiveGumbo parseDocumentWithString:simpleHTML];
        if (document) {
            //Let's see if we can get the header
            OGElement * title = (OGElement*)[document first:@"title"];
            NSLog(@"Title: %@", title.text);
        }
    }
    return 0;
}
