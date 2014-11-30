// @author Simon Toens on 11/30/14

#import <XCTest/XCTest.h>
#import "Assertion.h"

@interface AssertionTest : XCTestCase

@end

@implementation AssertionTest

- (void)testIllegalStateAssertion {
    NSString *reason = @"my reason";
    @try {
        [self badStateMethod:reason];
        XCTFail(@"Expected IllegalStateAssertion to be thrown");
    } @catch (IllegalStateAssertion *ass) {
        XCTAssertEqualObjects(ass.name, @"IllegalStateAssertion");
        XCTAssertEqualObjects(ass.reason, reason);
    }
}

- (void)badStateMethod:(NSString *)reason {
    @throw [IllegalStateAssertion withReason:reason];
}

@end