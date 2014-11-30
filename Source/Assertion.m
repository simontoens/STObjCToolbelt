// @author Simon Toens on 11/30/14

#import "Assertion.h"

@implementation Assertion
- (instancetype)initWithReason:(NSString *)reason {
    return [super initWithName:NSStringFromClass([self class]) reason:reason userInfo:nil];
}
@end

@implementation IllegalStateAssertion
+ (instancetype)withReason:(NSString *)reason {
    return [[IllegalStateAssertion alloc] initWithReason:reason];
}
@end

@implementation AbstractMethodAssertion
+ (instancetype)forSelector:(SEL)selector {
    return [[AbstractMethodAssertion alloc] initWithReason:[AbstractMethodAssertion getReason:selector]];
}
+ (NSString *)getReason:(SEL)selector {
    return [NSString stringWithFormat:@"The method '%@' is abstract, it must be implemented by a subclass", NSStringFromSelector(selector)];
}
@end

@implementation IllegalArgumentAssertion
+ (instancetype)withReason:(NSString *)reason {
    return [[IllegalArgumentAssertion alloc] initWithReason:reason];
}
@end