// @author Simon Toens 11/09/11

#import <SenTestingKit/SenTestingKit.h>
#import "MultiDictionary.h"

@interface MultiDictionaryTest : SenTestCase
@property (nonatomic, strong) MultiDictionary* multiDict;
@end

@implementation MultiDictionaryTest

@synthesize multiDict;

- (void)setUp {
    [super setUp];
    multiDict = [[MultiDictionary alloc] init];
}

- (void)testSetMultipleValuesForSingleKey {
    [multiDict setObject:@"a" forKey:@"1"];
    [multiDict setObject:@"b" forKey:@"1"];
    NSSet *set = [multiDict objectsForKey:@"1"];
    STAssertTrue([multiDict containsKey:@"1"], @"");
    STAssertEquals([set count], (NSUInteger)2, @"");
    STAssertTrue([set containsObject:@"a"], @"");
    STAssertTrue([set containsObject:@"b"], @"");
}

- (void)testDeleteKey {
    [multiDict setObject:@"a" forKey:@"1"];
    [multiDict setObject:@"b" forKey:@"1"];
    [multiDict removeObjectsForKey:@"1"];    
    STAssertFalse([multiDict containsKey:@"1"], @"");
}

- (void)testRemoveValue {
    [multiDict setObject:@"a" forKey:@"1"];
    [multiDict setObject:@"b" forKey:@"1"];
    [multiDict setObject:@"b" forKey:@"2"];
    [multiDict removeValue:@"b"];
    STAssertFalse([[multiDict objectsForKey:@"1"] containsObject:@"b"], @"");
    STAssertFalse([[multiDict objectsForKey:@"2"] containsObject:@"b"], @"");
}

- (void)testAllValues {
    [multiDict setObject:@"a" forKey:@"1"];
    [multiDict setObject:@"b" forKey:@"1"];
    [multiDict setObject:@"a" forKey:@"2"];
    [multiDict setObject:@"c" forKey:@"2"];
    NSArray *allValues = [multiDict allValues];
    STAssertEquals([allValues count], (NSUInteger)4, @"");
    STAssertTrue([allValues containsObject:@"a"], @"");
    STAssertTrue([allValues containsObject:@"b"], @"");
    STAssertTrue([allValues containsObject:@"c"], @"");
}

- (void)testCount {
    [multiDict setObject:@"a" forKey:@"1"];
    [multiDict setObject:@"b" forKey:@"1"];
    [multiDict setObject:@"a" forKey:@"2"];
    [multiDict setObject:@"c" forKey:@"2"];
    STAssertEquals(multiDict.count, (NSUInteger)2, @"");
}

- (void)testRemoveAllObjects {
    [multiDict setObject:@"a" forKey:@"1"];
    [multiDict setObject:@"c" forKey:@"2"];
    [multiDict removeAllObjects];
    STAssertEquals(multiDict.count, (NSUInteger)0, @"");    
}

@end