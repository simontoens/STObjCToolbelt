// @author Simon Toens on 07/04/11

#import <XCTest/XCTest.h>
#import "BiDictionary.h"

@interface BiDictionaryTest : XCTestCase {
@private
    BiDictionary* bidict;
}
@end

@implementation BiDictionaryTest

- (void)setUp {
    [super setUp];
    bidict = [[BiDictionary alloc] init];
}
             
- (void)testAddAndLookup {
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    XCTAssertEqual([bidict objectForKey:key], value, @"bad mapping");
    XCTAssertTrue([bidict containsKey:key], @"bad mapping");
    
    NSString *value2 = @"value2";
    [bidict setObject:value2 forKey:key];
    XCTAssertEqual([bidict objectForKey:key], value2, @"bad mapping");
    XCTAssertTrue([bidict containsKey:key], @"bad mapping");
}

- (void)testAddDuplicateValueSameKeyAndValue {
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    XCTAssertEqual([bidict objectForKey:key], value, @"bad mapping");    
    [bidict setObject:value forKey:key];    
    XCTAssertEqual([bidict objectForKey:key], value, @"bad mapping");
}

- (void)testAddDuplicateValueDifferentKey {
    NSString *value = @"value";
    [bidict setObject:value forKey:@"key1"];
    @try
    {
        [bidict setObject:value forKey:@"key2"];    
        XCTFail(@"Expected NSException to be thrown");
    } @catch (NSException *ex)
    {
        XCTAssertTrue(YES, @"");
    }
}

- (void)testNewMappingOverwritesOldValue {
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    NSString *value2 = @"value2";
    [bidict setObject:value2 forKey:key];
    XCTAssertTrue([[bidict inverse] containsKey:value2], @"");
    XCTAssertFalse([[bidict inverse] containsKey:value], @"");
}

- (void)testInverseLookup
{
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    XCTAssertEqual([[bidict inverse] objectForKey:value], key, @"bad mapping");
}

- (void)testInverseSet {
    NSString *key = @"key";
    NSString *value = @"value";
    [[bidict inverse] setObject:value forKey:key];
    XCTAssertEqual([bidict objectForKey:value], key, @"bad mapping");
}

- (void)testContainsKey {
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    XCTAssertTrue([bidict containsKey:key], @"bad mapping");
    XCTAssertTrue([[bidict inverse] containsKey:value], @"bad mapping");
    [bidict removeObjectForKey:key];
    XCTAssertFalse([bidict containsKey:key], @"bad mapping");
    XCTAssertFalse([[bidict inverse] containsKey:value], @"bad mapping");
}

- (void)testRemoveAllObjects {
    [bidict setObject:@"1" forKey:@"1"];
    [bidict setObject:@"2" forKey:@"2"];    
    [bidict setObject:@"3" forKey:@"3"];
    XCTAssertEqual(bidict.count, (NSUInteger)3, @"bad count");
    [bidict removeAllObjects];
    XCTAssertEqual(bidict.count, (NSUInteger)0, @"bad count");    
}

- (void)testInverseSameInstance {
    XCTAssertEqual([bidict inverse], [bidict inverse], @"bad inverse");
}

- (void)testInverseOfInverseIsSelf {
    XCTAssertEqual([[bidict inverse] inverse], bidict, @"bad inverse");
}

@end