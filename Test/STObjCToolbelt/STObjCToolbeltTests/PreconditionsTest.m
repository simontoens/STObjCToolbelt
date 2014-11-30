// @author Simon Toens 11/29/13

#import <XCTest/XCTest.h>
#import "Preconditions.h"

@interface PreconditionsTest : XCTestCase

@end

@implementation PreconditionsTest

- (void)testAssertNotEmptyWithPopulatedArray
{
    [Preconditions assertNotEmpty:@[@"1", @"2", @"3"]];
}

- (void)testAssertNotEmptyWithEmptyArray
{
    @try {
        [Preconditions assertNotEmpty:@[]];
        XCTFail(@"Expected exception to be thrown");
    } @catch (NSException *expected) {
        XCTAssertTrue(YES, @"expected");
    }
}

@end