// @author Simon Toens 10/23/11

#import "MultiDictionary.h"

@interface MultiDictionary()
@property (nonatomic, strong) NSMutableDictionary *dict;
@end

@implementation MultiDictionary

#pragma mark - Initializers

- (id)init {
    if (self = [super init]) {
        _dict = [[NSMutableDictionary alloc] init];
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
    return [self.dict objectForKey:key] != nil;
}

- (void)removeValue:(id)aValue {
    for (NSMutableSet *set in [self.dict allValues]) {
        [set removeObject:aValue];
    }
}

- (void)removeObjectsForKey:(id)aKey {
    [self.dict removeObjectForKey:aKey];
}

- (void)removeAllObjects {
    [self.dict removeAllObjects];
}

- (NSArray *)allKeys {
    return [self.dict allKeys];
}

- (NSArray *)allValues {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSSet *set in [self.dict allValues]) {
        [values addObjectsFromArray:[set allObjects]];
    }
    return values;
}

#pragma mark - Properties

- (NSUInteger)count {
    return [self.dict count];
}

#pragma mark - Private methods

- (NSMutableSet *)getSetForKey:(id)aKey {
    NSMutableSet *set = [self.dict objectForKey:aKey];
    if (!set) {
        set = [[NSMutableSet alloc] init];
        [self.dict setObject:set forKey:aKey];
    }
    return set;
}

@end