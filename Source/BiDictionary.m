/*
 * Created by Simon Toens on 07/04/11.
 * Copyright 2011 shrtlist.com. All rights reserved.
 */

#import "BiDictionary.h"


@interface BiDictionary()
- (id)initWithKeysMapping:(NSMutableDictionary *)aKeysToValues valuesMapping:(NSMutableDictionary *)aValuesToKeys inverse:(BiDictionary *)inverse;
- (void)throwException:(NSString *)reason;
@end

@interface BiDictionary()

@end

@implementation BiDictionary

#pragma mark - Initializers

- (id)init
{
    if ((self = [super init]))
    {
        self = [self initWithKeysMapping:[[NSMutableDictionary alloc] init] 
                    valuesMapping:[[NSMutableDictionary alloc] init]
                          inverse:nil];
    }
    
    return self;
}

- (id)initWithKeysMapping:(NSMutableDictionary *)aKeysToValues valuesMapping:(NSMutableDictionary *)aValuesToKeys inverse:(BiDictionary *)aInverse
{
    if ((self = [super init]))
    {
        keysToValues = aKeysToValues;
        valuesToKeys = aValuesToKeys;
        inverse = aInverse ? aInverse : [[BiDictionary alloc] initWithKeysMapping:valuesToKeys valuesMapping:keysToValues inverse:self];
    }
    return self;
}

#pragma mark - Dictionary methods

- (BiDictionary *)inverse
{
    return inverse;
}

- (void)setObject:(id)value forKey:(id)key
{
    if ([[keysToValues objectForKey:key] isEqual:value])
    {
        // if we already have this mapping, don't do anything        
        return;
    }
    
    if ([valuesToKeys objectForKey:value])
    {
        // cannot add a mapping that has the same value
        // (and a different key, see previous check)
        // as an already existing mapping
        [self throwException:@"duplicate value"];
    }
    
    id oldValue = [keysToValues objectForKey:key];
    if (oldValue)
    {
        [valuesToKeys removeObjectForKey:oldValue];
    }
    [keysToValues setObject:value forKey:key];
    [valuesToKeys setObject:key forKey:value];
}

- (void)removeObjectForKey:(id)key
{
    id value = [keysToValues objectForKey:key];
    if (value)
    {
        [keysToValues removeObjectForKey:key];
        [valuesToKeys removeObjectForKey:value];
    }
}

- (id)objectForKey:(id)key
{
    return [keysToValues objectForKey:key];
}

- (BOOL)containsKey:(id)key
{
    return [keysToValues objectForKey:key] != nil;
}

- (void)throwException:(NSString *)reason
{
    @throw [NSException exceptionWithName:@"BiDictionaryException" reason:reason userInfo:nil];
}

- (void)removeAllObjects
{
    [keysToValues removeAllObjects];
    [valuesToKeys removeAllObjects];
}

- (NSUInteger)count
{
    return [keysToValues count];
}

#pragma mark - NSObject impl

- (NSString *)description
{
    return [keysToValues description];
}

@end
