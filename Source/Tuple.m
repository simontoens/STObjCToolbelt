/*
 * Created by Simon Toens on 06/25/11.
 * Copyright 2011 shrtlist.com. All rights reserved.
 */

#import "Tuple.h"

@implementation Tuple

@synthesize t1, t2;

- (id)init:(id)at1 t2:(id)at2
{
    if ((self = [super init]))
    {
        self.t1 = at1;
        self.t2 = at2;
    }
    return self;
}

+ (Tuple *)getTuple:(id)t1 t2:(id)t2
{
    return [[Tuple alloc] init:t1 t2:t2];
}

#pragma mark - NSObject protocol methods

- (BOOL)isEqual:(id)anObject
{
    if (self == anObject) return YES;
    
    if (![anObject isKindOfClass:[Tuple class]]) return NO;
	
    Tuple* otherTuple = (Tuple *)anObject;
    
    return (([self.t1 isEqual:otherTuple.t1]) || (self.t1 == nil && otherTuple.t1 == nil)) &&
           (([self.t2 isEqual:otherTuple.t2]) || (self.t2 == nil && otherTuple.t2 == nil));   
}

- (NSUInteger)hash
{
    static int prime = 31;
    int result = prime + [t1 hash];
    result = prime * result + [t2 hash];
    return result;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"(%@, %@)", t1, t2];
}

@end