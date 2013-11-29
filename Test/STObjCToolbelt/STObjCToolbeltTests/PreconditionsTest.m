// @author Simon Toens 11/29/13

#import <SenTestingKit/SenTestingKit.h>
#import "Preconditions.h"

@interface PreconditionsTest : SenTestCase

@end

@implementation PreconditionsTest

- (void)testFail
{
    @try {
        [Preconditions fail:@"error"];
        STFail(@"Expected exception to be thrown");
    }
    @catch (NSException *expected) {
        STAssertTrue(YES, @"expected");
    }
}

@end