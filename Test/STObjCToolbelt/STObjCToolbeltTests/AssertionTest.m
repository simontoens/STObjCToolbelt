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
    } @catch (IllegalStateAssertion *ex) {
        XCTAssertEqualObjects(ex.name, @"IllegalStateAssertion");
        XCTAssertEqualObjects(ex.reason, reason);
    }
}

- (void)badStateMethod:(NSString *)reason {
    @throw [IllegalStateAssertion withReason:reason];
}

- (void)testAbstractMethodAssertion {
    @try {
        [self abstractMethod];
        XCTFail(@"Expected AbstractMethodAssertion to be thrown");
    } @catch (AbstractMethodAssertion *ex) {
        XCTAssertEqualObjects(ex.name, @"AbstractMethodAssertion");
        XCTAssertEqualObjects(ex.reason, @"The method 'abstractMethod' is abstract, it must be implemented by a subclass");
    }
}

- (void)abstractMethod {
    @throw [AbstractMethodAssertion forSelector:_cmd];
}

@end