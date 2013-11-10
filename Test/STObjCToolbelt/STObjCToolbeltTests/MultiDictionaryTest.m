// @author Simon Toens 11/09/11

#import <SenTestingKit/SenTestingKit.h>
#import "MultiDictionary.h"

@interface MultiDictionaryTest : SenTestCase
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
    STAssertTrue([self.multiDict containsKey:@"1"], @"");
    STAssertEquals([set count], (NSUInteger)2, @"");
    STAssertTrue([set containsObject:@"a"], @"");
    STAssertTrue([set containsObject:@"b"], @"");
}

- (void)testDeleteKey {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict removeObjectsForKey:@"1"];
    STAssertFalse([self.multiDict containsKey:@"1"], @"");
}

- (void)testRemoveValue {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"2"];
    [self.multiDict removeValue:@"b"];
    STAssertFalse([[self.multiDict objectsForKey:@"1"] containsObject:@"b"], @"");
    STAssertFalse([[self.multiDict objectsForKey:@"2"] containsObject:@"b"], @"");
}

- (void)testAllValues {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict setObject:@"a" forKey:@"2"];
    [self.multiDict setObject:@"c" forKey:@"2"];
    NSArray *allValues = [self.multiDict allValues];
    STAssertEquals([allValues count], (NSUInteger)4, @"");
    STAssertTrue([allValues containsObject:@"a"], @"");
    STAssertTrue([allValues containsObject:@"b"], @"");
    STAssertTrue([allValues containsObject:@"c"], @"");
}

- (void)testCount {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"b" forKey:@"1"];
    [self.multiDict setObject:@"a" forKey:@"2"];
    [self.multiDict setObject:@"c" forKey:@"2"];
    STAssertEquals(self.multiDict.count, (NSUInteger)2, @"");
}

- (void)testRemoveAllObjects {
    [self.multiDict setObject:@"a" forKey:@"1"];
    [self.multiDict setObject:@"c" forKey:@"2"];
    [self.multiDict removeAllObjects];
    STAssertEquals(self.multiDict.count, (NSUInteger)0, @"");
}

@end