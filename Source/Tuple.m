// @author Simon Toens 6/25/11

#import "Tuple.h"

@implementation Tuple

@synthesize t1 = _t1, t2 = _t2;

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
    static int prime = 31;
    int result = prime + [self.t1 hash];
    result = prime * result + [self.t2 hash];
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@, %@)", self.t1, self.t2];
}

@end