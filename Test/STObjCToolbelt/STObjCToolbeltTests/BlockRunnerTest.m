// @author Simon Toens on 07/04/11

#import <XCTest/XCTest.h>
#import "BlockRunner.h"

@interface BlockRunnerTest : XCTestCase {
    @private
    BlockRunner *runner;
}
@end

@implementation BlockRunnerTest

- (void)setUp {
    [super setUp];
    runner = [[BlockRunner alloc] initWithIdentifier:@"test"];
}

- (void)testRunBlock {
    
    runner = [runner newBlockRunnerAsyncAfterNumberOfBlocksExceeds:1];
    
    __block int i = 0;
    
    void(^myblock)() = ^() {
        i++;
    };
    
    [runner run:myblock];
    
    XCTAssertEqual(1, i, @"Expected block to have run");
}

- (void)testRunJobsWithForLoop {
    
    runner = [runner newBlockRunnerAsyncAfterNumberOfBlocksExceeds:3];
    
    NSMutableArray *widgets = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        [runner run:^{[self doStuff:i container:widgets];}];
    }
    
    XCTAssertEqual([widgets count], (NSUInteger)3, @"Expected sync blocks to have run");
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *expected = [NSString stringWithFormat:@"Got %lu", (unsigned long)i];
        XCTAssertEqualObjects([widgets objectAtIndex:i], expected, @"Bad widget");
    }
}

- (void)doStuff:(int)arg container:(NSMutableArray *)widgets {
    [widgets addObject:[NSString stringWithFormat:@"Got %i", arg]];
}

@end