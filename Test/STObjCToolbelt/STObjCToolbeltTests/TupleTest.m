// @author Simon Toens 6/25/11

#import <XCTest/XCTest.h>
#import "Tuple.h"

@interface TupleTest : XCTestCase
@end

@implementation TupleTest

- (void)testIsEqual {
    Tuple *t = [Tuple tupleWithValues:nil t2:nil];
    XCTAssertTrue([t isEqual:t], @"");
    XCTAssertTrue([t isEqual:[Tuple tupleWithValues:nil t2:nil]], @"");
    
    Tuple *t2 = [Tuple tupleWithValues:@"1" t2:nil];
    XCTAssertTrue([t2 isEqual:t2], @"");
    XCTAssertFalse([t2 isEqual:t], @"");
    XCTAssertTrue([t2 isEqual:[Tuple tupleWithValues:@"1" t2:nil]], @"");
    
    Tuple *t3 = [Tuple tupleWithValues:nil t2:@"2"];
    XCTAssertTrue([t3 isEqual:t3], @"");
    XCTAssertFalse([t3 isEqual:t], @"");
    XCTAssertFalse([t3 isEqual:t2], @"");
    XCTAssertTrue([t3 isEqual:[Tuple tupleWithValues:nil t2:@"2"]], @"");
    
    Tuple *t4 = [Tuple tupleWithValues:@"1" t2:@"2"];
    XCTAssertTrue([t4 isEqual:t4], @"");
    XCTAssertFalse([t4 isEqual:t3], @"");
    XCTAssertTrue([t4 isEqual:[Tuple tupleWithValues:@"1" t2:@"2"]], @"");
}

@end