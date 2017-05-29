//
//  TestOGElement.m
//  ObjectiveGumbo
//
//  Created by Richard Warrender on 14/05/2017.
//  Copyright © 2017 rwarrender. All rights reserved.
//

@import XCTest;
#import <ObjectiveGumbo/ObjectiveGumbo.h>

@interface TestOGElement : XCTestCase

@property (nonatomic, strong) OGDocument *document;

@end

@implementation TestOGElement

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

- (void)testClasses
{
    OGElement *divElement = [self.document[@"#crayon-5917e4208bf79456063252"] firstObject];
    XCTAssert(divElement.tag == OGTagDiv);
    
    NSArray *classes = divElement.classes;
    XCTAssert(classes.count == 6);
    
    XCTAssert([classes containsObject:@"crayon-syntax"]);
    XCTAssert([classes containsObject:@"crayon-theme-xcode"]);
    XCTAssert([classes containsObject:@"crayon-font-liberation-mono"]);
    XCTAssert([classes containsObject:@"crayon-os-mac"]);
    XCTAssert([classes containsObject:@"print-yes"]);
    XCTAssert([classes containsObject:@"notranslate"]);
    XCTAssertFalse([classes containsObject:@"random"], @"Reporting class exists when it shouldn't");
    
    XCTAssert([divElement hasClassNamed:@"crayon-syntax"]);
    XCTAssertFalse([divElement hasClassNamed:@"random"]);
}

- (void)testAttributes
{
    OGElement *divElement = [self.document[@"#crayon-5917e4208bf79456063252"] firstObject];
    XCTAssert(divElement.tag == OGTagDiv);
    
    NSString *dataSettings = divElement.attributes[@"data-settings"];
    XCTAssertNotNil(dataSettings);
    
    XCTAssert([dataSettings isEqualToString:@" minimize scroll-always  expand"]);
}

- (void)testSubscriptingSearch
{
    OGElement *elementOne = [self.document[@"#main"] firstObject];
    XCTAssert(elementOne.tag == OGTagDiv);
    XCTAssert(elementOne.tagNamespace == OGNamespaceHTML);
    
    OGElement *elementTwo = [self.document[@".site-main"] firstObject];
    OGElement *elementThree = [self.document[@"#primary"] firstObject];
    
    XCTAssert(elementOne == elementTwo, @"These should be same objects");
    XCTAssertFalse(elementOne == elementThree, @"These should be different objects");
    
    OGElement *heading = [self.document[@"article h1"] firstObject];
    XCTAssertNotNil(heading);
    XCTAssert(heading.tag == OGTagH1);
    
    // Check contains article in hierarchy
    OGElement *target = heading;
    while( (target = (OGElement *)target.parent) ) {
        if (target.tag == OGTagArticle) {
            break;
        }
    }
    XCTAssert(target.tag == OGTagArticle);
    
    OGElement *header1 = [self.document[@"#masthead.site-header"] firstObject];
    XCTAssertNotNil(header1);
    XCTAssert(header1.tag == OGTagHeader);
    
    OGElement *header2 = [self.document[@".site-header"] firstObject];
    XCTAssertNotNil(header2);
    
    XCTAssert(header1 == header2);
    
    OGElement *header3 = [self.document[@"site-header"] firstObject];
    XCTAssertNil(header3, @"Non existance site-header should return nil");
    
    NSArray<OGElement *>* pElements = self.document[@"p"];
    for (OGElement *pElement in pElements) {
        XCTAssert(pElement.tag == OGTagP);
    }
}

@end
