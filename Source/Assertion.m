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

+ (instancetype)assertion {
    return [[AbstractMethodAssertion alloc] initWithReason:@"This method is abstract, it must be implemented by a subclass"];
}

@end
