// @author Simon Toens 6/25/11

#import <SenTestingKit/SenTestingKit.h>
#import "Tuple.h"

@interface TupleTest : SenTestCase

@end

@implementation TupleTest

- (void)testIsEqual {
    Tuple *t = [Tuple tupleWithValues:nil t2:nil];
    STAssertTrue([t isEqual:t], @"");
    STAssertTrue([t isEqual:[Tuple tupleWithValues:nil t2:nil]], @"");
    
    Tuple *t2 = [Tuple tupleWithValues:@"1" t2:nil];
    STAssertTrue([t2 isEqual:t2], @"");
    STAssertFalse([t2 isEqual:t], @"");
    STAssertTrue([t2 isEqual:[Tuple tupleWithValues:@"1" t2:nil]], @"");
    
    Tuple *t3 = [Tuple tupleWithValues:nil t2:@"2"];
    STAssertTrue([t3 isEqual:t3], @"");
    STAssertFalse([t3 isEqual:t], @"");
    STAssertFalse([t3 isEqual:t2], @"");
    STAssertTrue([t3 isEqual:[Tuple tupleWithValues:nil t2:@"2"]], @"");
    
    Tuple *t4 = [Tuple tupleWithValues:@"1" t2:@"2"];
    STAssertTrue([t4 isEqual:t4], @"");
    STAssertFalse([t4 isEqual:t3], @"");
    STAssertTrue([t4 isEqual:[Tuple tupleWithValues:@"1" t2:@"2"]], @"");
}

@end