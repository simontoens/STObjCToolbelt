// Created by Simon Toens on 10/23/11.

#import "MultiDictionary.h"

@interface MultiDictionary()
- (NSMutableSet *)getSetForKey:(id)aKey;
@end

@implementation MultiDictionary

#pragma mark - Initializers

- (id)init {
    if ((self = [super init])) {
        dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (void)setObject:(id)anObject forKey:(id)aKey {
    [[self getSetForKey:aKey] addObject:anObject];
}

- (NSSet *)objectsForKey:(id)aKey {
    return [self getSetForKey:aKey];
}

- (BOOL)containsKey:(id)key {
    return [dict objectForKey:key] != nil;
}

- (NSMutableSet *)getSetForKey:(id)aKey {
    NSMutableSet *set = [dict objectForKey:aKey];
    if (!set) {
        set = [[NSMutableSet alloc] init];
        [dict setObject:set forKey:aKey];
    }
    return set;
}

- (void)removeValue:(id)aValue {
    for (NSMutableSet *set in [dict allValues]) {
        [set removeObject:aValue];
    }
}

- (void)removeObjectsForKey:(id)aKey {
    [dict removeObjectForKey:aKey];
}

- (void)removeAllObjects {
    [dict removeAllObjects];
}

- (NSArray *)allKeys {
    return [dict allKeys];
}

- (NSArray *)allValues {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSSet *set in [dict allValues]) {
        [values addObjectsFromArray:[set allObjects]];
    }
    return values;
}

- (NSUInteger)count {
    return [dict count];
}

@end
