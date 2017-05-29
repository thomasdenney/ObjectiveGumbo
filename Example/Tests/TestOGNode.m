//
//  TestOGNode.m
//  ObjectiveGumbo
//
//  Created by Richard Warrender on 14/05/2017.
//  Copyright © 2017 rwarrender. All rights reserved.
//

@import XCTest;
#import <ObjectiveGumbo/ObjectiveGumbo.h>

@interface TestOGNode : XCTestCase

@property (nonatomic, strong) OGDocument *document;

@end

@implementation TestOGNode

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

- (void)testHierarchy
{
    OGElement *grandParentNode = [self.document[@"#page"] firstObject];
    XCTAssertNotNil(grandParentNode);
    
    OGElement *parentNode = [grandParentNode[@"#masthead"] firstObject];
    XCTAssertNotNil(parentNode);
    
    OGElement *node = [parentNode[@".site-header-info"] firstObject];
    XCTAssertNotNil(node);
    
    OGElement *childNode = [node[@".site-logo"] firstObject];
    XCTAssertNotNil(childNode);
    
    OGElement *greatGrandChildNode = [childNode[@"img"] firstObject];
    XCTAssertNotNil(greatGrandChildNode);
    
    // Descendant check
    XCTAssert([node isDescendantOfNode:grandParentNode]);
    XCTAssert([node isDescendantOfNode:parentNode]);
    XCTAssert(node.parent == parentNode);
    
    // Ancestor check
    XCTAssert([node isAncestorOfNode:childNode]);
    XCTAssert([node isAncestorOfNode:greatGrandChildNode]);
    XCTAssert(childNode.parent == node);
    
    // Inverted check
    XCTAssertFalse([node isAncestorOfNode:grandParentNode]);
    XCTAssertFalse([node isDescendantOfNode:childNode]);
    XCTAssertFalse([grandParentNode.children containsObject:greatGrandChildNode]);
    
    // Check children attributes
    XCTAssert([grandParentNode.children containsObject:parentNode]);
    XCTAssert([node.children containsObject:childNode]);
    XCTAssert([childNode.children containsObject:greatGrandChildNode]);
    
    XCTAssert(node.ownerDocument == self.document);
}

@end
