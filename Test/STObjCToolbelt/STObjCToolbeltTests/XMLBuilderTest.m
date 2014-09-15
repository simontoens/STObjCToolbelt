// @author Simon Toens 01/06/13

#import <XCTest/XCTest.h>
#import "XMLBuilder.h"

@interface XMLBuilderTest : XCTestCase {
@private
    XMLBuilder *builder;
}
@end

@implementation XMLBuilderTest

- (void)setUp {
    [super setUp];
    builder = [[XMLBuilder alloc] init];
    builder.includeXmlProcessingInstruction = NO;
}

- (void)testEmptyDocument {
    XCTAssertEqualObjects(builder.xml, @"", @"Bad empty document");
}

- (void)testSingleElement {
    [builder addElement:@"e1"];
    [builder closeAllElements];
    XCTAssertEqualObjects(builder.xml, @"<e1></e1>", @"Bad document");
}

- (void)testTextElement {
    [builder addElement:@"e1" value:@"text"];
    XCTAssertEqualObjects(builder.xml, @"<e1>text</e1>", @"Bad document");
}

@end