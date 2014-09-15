// @author Simon Toens 11/09/11

#import <XCTest/XCTest.h>
#import "MultiDictionary.h"

@interface MultiDictionaryTest : XCTestCase
@property (nonatomic, strong) MultiDictionary* multiDict;
@end

@implementation MultiDictionaryTest

- (void)setUp {
    [super setUp];
    self.multiDict = [[MultiDictionary alloc] init];
}

- (void)testSetMultipleValuesForSingleKey {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    NSSet *set = [self.multiDict objectsForKey:@"1"];
    XCTAssertTrue([self.multiDict containsKey:@"1"], @"");
    XCTAssertEqual([set count], (NSUInteger)2, @"");
    XCTAssertTrue([set containsObject:@"a"], @"");
    XCTAssertTrue([set containsObject:@"b"], @"");
}

- (void)testDeleteKey {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict removeObjectsForKey:@"1"];
    XCTAssertFalse([self.multiDict containsKey:@"1"], @"");
}

- (void)testRemoveValue {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"2"];
    [self.multiDict removeValue:@"b"];
    XCTAssertFalse([[self.multiDict objectsForKey:@"1"] containsObject:@"b"], @"");
    XCTAssertFalse([[self.multiDict objectsForKey:@"2"] containsObject:@"b"], @"");
}

- (void)testAllValues {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict setObject:@"a" forKey:@"2"];
    [self.multiDict setObject:@"c" forKey:@"2"];
    NSArray *allValues = [self.multiDict allValues];
    XCTAssertEqual([allValues count], (NSUInteger)4, @"");
    XCTAssertTrue([allValues containsObject:@"a"], @"");
    XCTAssertTrue([allValues containsObject:@"b"], @"");
    XCTAssertTrue([allValues containsObject:@"c"], @"");
}

- (void)testCount {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict setObject:@"a" forKey:@"2"];
    [self.multiDict setObject:@"c" forKey:@"2"];
    XCTAssertEqual(self.multiDict.count, (NSUInteger)2, @"");
}

- (void)testRemoveAllObjects {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"c" forKey:@"2"];
    [self.multiDict removeAllObjects];
    XCTAssertEqual(self.multiDict.count, (NSUInteger)0, @"");
}

@end