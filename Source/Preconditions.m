// @author Simon Toens 01/05/13

#import "Preconditions.h"

@implementation Preconditions

+ (void)assertArg:(NSString *)message condition:(BOOL)condition {
    if (!condition) {
        @throw [NSException exceptionWithName:@"InvalidArgumentException" reason:message userInfo:nil];
    }
}

+ (void)assertNotNil:(id)thing {
    [Preconditions assertArg:@"nil not allowed" condition:thing != nil];
}

+ (void)assertNotEmpty:(id)collection {
    [Preconditions assertNotNil:collection];
    if ([collection respondsToSelector:@selector(count)]) {
        [Preconditions assertArg:@"count of 0 not allowed" condition:[collection count] > 0];
    }
}

@end