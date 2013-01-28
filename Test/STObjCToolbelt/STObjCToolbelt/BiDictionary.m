// @author Simon Toens on 07/04/11

#import "BiDictionary.h"

@interface BiDictionary() {
@private
    NSMutableDictionary *keysToValues;
    NSMutableDictionary *valuesToKeys;
    BiDictionary *inverse;
}

- (id)initWithKeysMapping:(NSMutableDictionary *)aKeysToValues valuesMapping:(NSMutableDictionary *)aValuesToKeys inverse:(BiDictionary *)inverse;
- (void)throwException:(NSString *)reason;

@end

@implementation BiDictionary

#pragma mark - Initializers

- (id)init {
    return [self initWithKeysMapping:[[NSMutableDictionary alloc] init] 
                       valuesMapping:[[NSMutableDictionary alloc] init]
                             inverse:nil];
}

- (id)initWithKeysMapping:(NSMutableDictionary *)aKeysToValues valuesMapping:(NSMutableDictionary *)aValuesToKeys inverse:(BiDictionary *)aInverse
{
    if ((self = [super init])) {
        keysToValues = aKeysToValues;
        valuesToKeys = aValuesToKeys;
        inverse = aInverse ? aInverse : [[BiDictionary alloc] initWithKeysMapping:valuesToKeys valuesMapping:keysToValues inverse:self];
    }
    return self;
}

#pragma mark - Public methods

- (BiDictionary *)inverse {
    return inverse;
}

- (void)setObject:(id)value forKey:(id)key {
    if ([[keysToValues objectForKey:key] isEqual:value]) {
        return;
    }
    
    if ([valuesToKeys objectForKey:value]) {
        [self throwException:@"duplicate value"];
    }
    
    id oldValue = [keysToValues objectForKey:key];
    if (oldValue) {
        [valuesToKeys removeObjectForKey:oldValue];
    }
    [keysToValues setObject:value forKey:key];
    [valuesToKeys setObject:key forKey:value];
}

- (void)removeObjectForKey:(id)key {
    id value = [keysToValues objectForKey:key];
    if (value) {
        [keysToValues removeObjectForKey:key];
        [valuesToKeys removeObjectForKey:value];
    }
}

- (id)objectForKey:(id)key {
    return [keysToValues objectForKey:key];
}

- (BOOL)containsKey:(id)key {
    return [keysToValues objectForKey:key] != nil;
}

#pragma mark - Private methods

- (void)throwException:(NSString *)reason {
    @throw [NSException exceptionWithName:@"BiDictionaryException" reason:reason userInfo:nil];
}

- (void)removeAllObjects {
    [keysToValues removeAllObjects];
    [valuesToKeys removeAllObjects];
}

- (NSUInteger)count {
    return [keysToValues count];
}

#pragma mark - NSObject impl

- (NSString *)description {
    return [keysToValues description];
}

@end