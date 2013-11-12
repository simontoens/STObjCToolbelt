// @author Simon Toens on 07/04/11

#import <SenTestingKit/SenTestingKit.h>
#import "AsyncBlockRunner.h"

@interface AsyncBlockRunnerTest : SenTestCase {
    @private
    AsyncBlockRunner *runner;
}
@end

@implementation AsyncBlockRunnerTest

- (void)setUp {
    [super setUp];
    runner = [[AsyncBlockRunner alloc] init];
}

- (void)testRunJobs {
    
    __block int i = 0;
    
    void(^myblock)() = ^() {
        i++;
    };
    
    [runner runJobsAndWait:[NSArray arrayWithObjects:myblock, myblock, myblock, nil]];
    
    STAssertEquals(3, i, @"Expected blocks to have run");
}

@end
