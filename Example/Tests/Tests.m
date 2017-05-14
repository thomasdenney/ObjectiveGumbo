//
//  ObjectiveGumboTests.m
//  ObjectiveGumboTests
//
//  Created by rwarrender on 05/14/2017.
//  Copyright (c) 2017 rwarrender. All rights reserved.
//

@import XCTest;
#import <ObjectiveGumbo/ObjectiveGumbo.h>

@interface Tests : XCTestCase

@property (nonatomic, strong) OGDocument *document;

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    
    NSString *testDirectory = [[NSBundle bundleForClass:[self class]] resourcePath];
    NSString *htmlFile = [testDirectory stringByAppendingPathComponent:@"blog-encryption.html"];
    NSData *data = [NSData dataWithContentsOfFile:htmlFile];

    self.document = [ObjectiveGumbo documentWithData:data encoding:NSUTF8StringEncoding error:nil];
}

- (void)tearDown
{
    self.document = nil;
    [super tearDown];
}

- (void)testParts
{
    XCTAssert(self.document.hasDocType, "Missing doctype");
    XCTAssertFalse(self.document.quirksMode, "HTML demo should not be using quirks mode");
    
    XCTAssert([self.document.name isEqualToString:@"html"], "Document name is not html");
    XCTAssert([self.document.systemIdentifier isEqualToString:@""], "HTML file does not have system identifier and is reporting one!");
    XCTAssert([self.document.publicIdentifier isEqualToString:@""], "HTML file does not have public identifier and is reporting one!");
    
    
    OGElement *head = self.document.head;
    XCTAssertNotNil(head, "Head property should not return nil when containing a valid document");
    XCTAssert([head isKindOfClass:[OGElement class]], "Head should return OGElement class type");
    XCTAssert(head.tag == OGTagHead, "Head is not a <head> tag");
    
    OGElement *body = self.document.body;
    XCTAssertNotNil(body, "Body property should not return nil when containing a valid document");
    XCTAssert([body isKindOfClass:[OGElement class]], "Body should return OGElement class type");
    XCTAssert(body.tag == OGTagBody, "Body is not a <body> tag");
}

@end

