// @author Simon Toens on 07/04/11

#import <SenTestingKit/SenTestingKit.h>
#import "BiDictionary.h"

@interface BiDictionaryTest : SenTestCase {
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
    STAssertEquals([bidict objectForKey:key], value, @"bad mapping");
    STAssertTrue([bidict containsKey:key], @"bad mapping");
    
    NSString *value2 = @"value2";
    [bidict setObject:value2 forKey:key];
    STAssertEquals([bidict objectForKey:key], value2, @"bad mapping");
    STAssertTrue([bidict containsKey:key], @"bad mapping");
}

- (void)testAddDuplicateValueSameKeyAndValue {
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    STAssertEquals([bidict objectForKey:key], value, @"bad mapping");    
    [bidict setObject:value forKey:key];    
    STAssertEquals([bidict objectForKey:key], value, @"bad mapping");
}

- (void)testAddDuplicateValueDifferentKey {
    NSString *value = @"value";
    [bidict setObject:value forKey:@"key1"];
    @try
    {
        [bidict setObject:value forKey:@"key2"];    
        STFail(@"Expected NSException to be thrown");
    } @catch (NSException *ex)
    {
        STAssertTrue(YES, @"");
    }
}

- (void)testNewMappingOverwritesOldValue {
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    NSString *value2 = @"value2";
    [bidict setObject:value2 forKey:key];
    STAssertTrue([[bidict inverse] containsKey:value2], @"");
    STAssertFalse([[bidict inverse] containsKey:value], @"");
}

- (void)testInverseLookup
{
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    STAssertEquals([[bidict inverse] objectForKey:value], key, @"bad mapping");
}

- (void)testInverseSet {
    NSString *key = @"key";
    NSString *value = @"value";
    [[bidict inverse] setObject:value forKey:key];
    STAssertEquals([bidict objectForKey:value], key, @"bad mapping");
}

- (void)testContainsKey {
    NSString *key = @"key";
    NSString *value = @"value";
    [bidict setObject:value forKey:key];
    STAssertTrue([bidict containsKey:key], @"bad mapping");
    STAssertTrue([[bidict inverse] containsKey:value], @"bad mapping");
    [bidict removeObjectForKey:key];
    STAssertFalse([bidict containsKey:key], @"bad mapping");
    STAssertFalse([[bidict inverse] containsKey:value], @"bad mapping");
}

- (void)testRemoveAllObjects {
    [bidict setObject:@"1" forKey:@"1"];
    [bidict setObject:@"2" forKey:@"2"];    
    [bidict setObject:@"3" forKey:@"3"];
    STAssertEquals(bidict.count, (NSUInteger)3, @"bad count");
    [bidict removeAllObjects];
    STAssertEquals(bidict.count, (NSUInteger)0, @"bad count");    
}

- (void)testInverseSameInstance {
    STAssertEquals([bidict inverse], [bidict inverse], @"bad inverse");
}

- (void)testInverseOfInverseIsSelf {
    STAssertEquals([[bidict inverse] inverse], bidict, @"bad inverse");
}

@end