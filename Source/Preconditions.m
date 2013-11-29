// @author Simon Toens 01/05/13

#import "Preconditions.h"

@implementation Preconditions

+ (void)assertNotNil:(id)thing {
    [Preconditions assertNotNil:thing message:nil];
}

+ (void)assertNotNil:(id)thing message:(NSString *)message {
    [Preconditions assert:thing != nil message:message];
}

+ (void)assertNotEmpty:(id)collection {
    [Preconditions assertNotEmpty:collection message:nil];
}

+ (void)assertNotEmpty:(id)collection message:(NSString *)message {
    [Preconditions assertNotNil:collection];
    if ([collection respondsToSelector:@selector(count)]) {
        [Preconditions assert:[collection count] > 0 message:message];
    }
}

+ (void)fail:(NSString *)message
{
    [Preconditions assert:NO message:message];
}

+ (void)assert:(BOOL)condition message:(NSString *)message {
    if (!condition) {
        @throw [NSException exceptionWithName:@"InvalidArgumentException" reason:message userInfo:nil];
    }
}

@end