// @author Simon Toens 10/10/10

#import <SenTestingKit/SenTestingKit.h>
#import "Stack.h"
#import "Tuple.h"

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

- (void)testEquality {
    [stack push:@"a"];
    Stack *stack2 = [[Stack alloc] init];
    [stack2 push:@"a"];
	STAssertEqualObjects(stack, stack2, @"stacks are not equal");
}

- (void)testHashCode {
    [stack push:@"a"];
    Stack *stack2 = [[Stack alloc] init];
    [stack2 push:@"a"];
	STAssertEquals([stack hash], [stack2 hash], @"stacks don't have the same hash code");
}

- (void)testCopy {
    Tuple *t = [Tuple tupleWithValues:@"a" t2:@"b"];
    [stack push:t];
    Stack *copy = [stack copy];
    STAssertEqualObjects(stack, copy, @"Copies should be equal");
    STAssertFalse([copy pop] == t, @"Copies should be deep");
}

- (void)testAllObjects {
	id thing = [[NSObject alloc] init];
    [stack push:thing];
	id otherThing = [[NSObject alloc] init];
	[stack push:otherThing];
    NSArray *items = [stack allObjects];
	STAssertEquals([items objectAtIndex:0], thing, @"Unexpected item");
    STAssertEquals([items objectAtIndex:1], otherThing, @"Unexpected item");    
}

@end