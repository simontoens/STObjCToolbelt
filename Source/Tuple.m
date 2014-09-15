// @author Simon Toens 6/25/11

#import "Tuple.h"

@implementation Tuple

#pragma mark - Initializers

+ (Tuple *)tupleWithValues:(id)t1 t2:(id)t2 {
    return [[Tuple alloc] init:t1 t2:t2];
}

- (id)init:(id)t1 t2:(id)t2 {
    if (self = [super init]) {
        _t1 = t1;
        _t2 = t2;
    }
    return self;
}


#pragma mark - NSObject protocol methods

- (BOOL)isEqual:(id)anObject {
    if (self == anObject) {
        return YES;
    }
    
    if (![anObject isKindOfClass:[Tuple class]]) {
        return NO;
    }
	
    Tuple *otherTuple = (Tuple *)anObject;
    
    return (([self.t1 isEqual:otherTuple.t1]) || (self.t1 == nil && otherTuple.t1 == nil)) &&
           (([self.t2 isEqual:otherTuple.t2]) || (self.t2 == nil && otherTuple.t2 == nil));   
}

- (NSUInteger)hash {
    static NSUInteger prime = 31;
    NSUInteger result = prime + [self.t1 hash];
    result = prime * result + [self.t2 hash];
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@, %@)", self.t1, self.t2];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [Tuple tupleWithValues:[self.t1 copyWithZone:zone] t2:[self.t2 copyWithZone:zone]];
}

@end