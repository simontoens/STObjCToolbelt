// @author Simon Toens 01/05/13

#import "Preconditions.h"

@implementation Preconditions

+ (void)assertArg:(NSString *)message condition:(BOOL)condition {
    if (!condition) {
        @throw [NSException exceptionWithName:@"InvalidArgumentException" reason:message userInfo:nil];
    }
}

@end