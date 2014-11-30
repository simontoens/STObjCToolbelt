// @author Simon Toens on 11/30/14

#import <Foundation/Foundation.h>

/**
 * Abstract base assertion.
 */
@interface Assertion : NSException

- (instancetype)init __unavailable;

- (instancetype)initWithReason:(NSString *)reason;

@end


/**
 * Concrete assertions
 */
@interface IllegalStateAssertion : Assertion
+ (instancetype)withReason:(NSString *)reason;
- (instancetype)init __unavailable;
@end

@interface AbstractMethodAssertion : Assertion
+ (instancetype)assertion;
- (instancetype)init __unavailable;
@end

