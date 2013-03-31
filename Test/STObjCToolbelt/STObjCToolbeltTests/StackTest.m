// @author Simon Toens 10/10/10

#import <SenTestingKit/SenTestingKit.h>
#import "Stack.h"

@interface StackTest : SenTestCase {
    Stack *stack;
}

@end

@implementation StackTest

- (void)setUp {
    [super setUp];
	stack = [[Stack alloc] init];
}

- (void)testStack {
	STAssertEquals(stack.count, (NSUInteger)0, @"Stack size should be 0");
    STAssertTrue(stack.empty, @"Stack should be empty");
    
	id thing = [[NSObject alloc] init];
    [stack push:thing];
	STAssertEquals(stack.count, (NSUInteger)1, @"Stack size should be 1");
    STAssertFalse(stack.empty, @"Stack should not be empty");
    
	id otherThing = [[NSObject alloc] init];
	[stack push:otherThing];
    
	STAssertEquals(stack.count, (NSUInteger)2, @"Stack size should be 2");
    STAssertEquals([stack peak], otherThing, @"pushed thing not equal to peaked thing");
    STAssertEquals(stack.count, (NSUInteger)2, @"Stack size should be 2");
	STAssertEquals([stack pop], otherThing, @"pushed thing not equal to popped thing");
    
	STAssertEquals(stack.count, (NSUInteger)1, @"Stack size should be 1");
	STAssertEquals([stack pop], thing, @"pushed thing not equal to popped thing");
	STAssertEquals(stack.count, (NSUInteger)0, @"Stack size should be 0");
    STAssertTrue(stack.empty, @"Stack should be empty");
}

- (void)testPopPeakEmptyStack {
    STAssertTrue([stack pop] == nil, @"Expected nil");
    STAssertTrue([stack peak] == nil, @"Expected nil");
}

@end