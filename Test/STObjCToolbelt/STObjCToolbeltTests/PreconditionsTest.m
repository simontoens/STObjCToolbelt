// @author Simon Toens 11/29/13

#import <XCTest/XCTest.h>
#import "Preconditions.h"

@interface PreconditionsTest : XCTestCase

@end

@implementation PreconditionsTest

- (void)testFail
{
    @try {
        [Preconditions fail:@"error"];
        XCTFail(@"Expected exception to be thrown");
    }
    @catch (NSException *expected) {
        XCTAssertTrue(YES, @"expected");
    }
}

@end