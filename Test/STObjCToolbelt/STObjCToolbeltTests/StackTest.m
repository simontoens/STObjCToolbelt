// @author Simon Toens 10/10/10

#import <XCTest/XCTest.h>
#import "Stack.h"
#import "Tuple.h"

@interface StackTest : XCTestCase {
    Stack *stack;
}

@end

@implementation StackTest

- (void)setUp {
    [super setUp];
	stack = [[Stack alloc] init];
}

- (void)testStack {
	XCTAssertEqual(stack.count, (NSUInteger)0, @"Stack size should be 0");
    XCTAssertTrue(stack.empty, @"Stack should be empty");
    
	id thing = [[NSObject alloc] init];
    [stack push:thing];
	XCTAssertEqual(stack.count, (NSUInteger)1, @"Stack size should be 1");
    XCTAssertFalse(stack.empty, @"Stack should not be empty");
    
	id otherThing = [[NSObject alloc] init];
	[stack push:otherThing];
    
	XCTAssertEqual(stack.count, (NSUInteger)2, @"Stack size should be 2");
    XCTAssertEqual([stack peek], otherThing, @"pushed thing not equal to peaked thing");
    XCTAssertEqual(stack.count, (NSUInteger)2, @"Stack size should be 2");
	XCTAssertEqual([stack pop], otherThing, @"pushed thing not equal to popped thing");
    
	XCTAssertEqual(stack.count, (NSUInteger)1, @"Stack size should be 1");
	XCTAssertEqual([stack pop], thing, @"pushed thing not equal to popped thing");
	XCTAssertEqual(stack.count, (NSUInteger)0, @"Stack size should be 0");
    XCTAssertTrue(stack.empty, @"Stack should be empty");
}

- (void)testPopPeakEmptyStack {
    XCTAssertTrue([stack pop] == nil, @"Expected nil");
    XCTAssertTrue([stack peek] == nil, @"Expected nil");
}

- (void)testEquality {
    [stack push:@"a"];
    Stack *stack2 = [[Stack alloc] init];
    [stack2 push:@"a"];
	XCTAssertEqualObjects(stack, stack2, @"stacks are not equal");
}

- (void)testHashCode {
    [stack push:@"a"];
    Stack *stack2 = [[Stack alloc] init];
    [stack2 push:@"a"];
	XCTAssertEqual([stack hash], [stack2 hash], @"stacks don't have the same hash code");
}

- (void)testCopy {
    Tuple *t = [Tuple tupleWithValues:@"a" t2:@"b"];
    [stack push:t];
    Stack *copy = [stack copy];
    XCTAssertEqualObjects(stack, copy, @"Copies should be equal");
    XCTAssertFalse([copy pop] == t, @"Copies should be deep");
}

- (void)testAllObjects {
	id thing = [[NSObject alloc] init];
    [stack push:thing];
	id otherThing = [[NSObject alloc] init];
	[stack push:otherThing];
    NSArray *items = [stack allObjects];
	XCTAssertEqual([items objectAtIndex:0], thing, @"Unexpected item");
    XCTAssertEqual([items objectAtIndex:1], otherThing, @"Unexpected item");    
}

@end