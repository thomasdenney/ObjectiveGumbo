//
//  ObjectiveGumboTests.m
//  ObjectiveGumboTests
//
//  Created by rwarrender on 05/14/2017.
//  Copyright (c) 2017 rwarrender. All rights reserved.
//

@import XCTest;
#import <ObjectiveGumbo/ObjectiveGumbo.h>

@interface TestOGDocument : XCTestCase

@property (nonatomic, strong) OGDocument *document;

@end

@implementation TestOGDocument

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

- (void)testDocumentInfo
{
    XCTAssert(self.document.hasDocType, "Missing doctype");
    XCTAssertFalse(self.document.quirksMode, "HTML demo should not be using quirks mode");
    
    XCTAssert([self.document.name isEqualToString:@"html"], "Document name is not html");
    XCTAssert([self.document.systemIdentifier isEqualToString:@""], "HTML file does not have system identifier and is reporting one!");
    XCTAssert([self.document.publicIdentifier isEqualToString:@""], "HTML file does not have public identifier and is reporting one!");
}

- (void)testMetaTagExtraction
{
    NSArray<NSString *>* allMetaNames = self.document.allMetaNames;

    XCTAssert(allMetaNames.count == 10, @"Not counting meta tag names property");
    XCTAssert(self.document.metas.count == 33, @"Not counting meta tag names property");
    
    NSArray<OGElement *>* metas = self.document.metas;
    XCTAssertNotNil(metas, "Metas property should not return nil when containing a valid document");
    for (OGElement *meta in metas) {
        XCTAssert(meta.tag == OGTagMeta, @"Meta element should be an meta tag");
    }
    
    for (int i = 0; i<allMetaNames.count; i++) {
        NSString *name = allMetaNames[i];
        OGElement *meta = self.document.namedMetas[name];
        
        XCTAssert(meta.tag == OGTagMeta, @"Meta element should be an meta tag");
        XCTAssert([meta.attributes[@"name"] length] > 0, @"Meta element should have a name atrribute");
    }
}

- (void)testConvenienceMethods
{
    NSArray<OGElement *>* anchors = self.document.anchors;
    XCTAssertNotNil(anchors, "Anchors property should not return nil when containing a valid document");
    for (OGElement *anchor in anchors) {
        XCTAssert(anchor.tag == OGTagA, @"Anchor element should be an a tag");
        
        NSString *name = anchor.attributes[@"name"];
        XCTAssert(name.length > 0, @"Anchor name should not be empty");
    }
    
    NSArray<OGElement *>* links = self.document.links;
    XCTAssertNotNil(links, "Links property should not return nil when containing a valid document");
    for (OGElement *link in links) {
        BOOL isATagOrAreaTag = (link.tag == OGTagA) || (link.tag == OGTagArea);
        XCTAssert(isATagOrAreaTag, @"Link element should be an a tag");
        
        NSString *url = link.attributes[@"href"];
        XCTAssert(url.length > 0, @"Link HREF should not be empty");
    }

    NSArray<OGElement *>* images = self.document.images;
    XCTAssertNotNil(images, "Images property should not return nil when containing a valid document");
    for (OGElement *img in images) {
        XCTAssert(img.tag == OGTagImg, @"Img element should be an a tag");
    }
    
    NSArray<OGElement *>* forms = self.document.forms;
    XCTAssertNotNil(forms, "Forms property should not return nil when containing a valid document");
    for (OGElement *form in forms) {
        XCTAssert(form.tag == OGTagForm, @"Form element should be an a tag");
        
        NSString *action = form.attributes[@"action"];
        XCTAssert([action isEqualToString:@"https://richardwarrender.com/wp-comments-post.php"], "Form action not present");
    }
}

- (void)testBodyStructure
{
    XCTAssert([self.document.title isEqualToString:@"Encrypt data using AES and 256-bit keys - Richard Warrender"], "Document title is not returning");
    
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

