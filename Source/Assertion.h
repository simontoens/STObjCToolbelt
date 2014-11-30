// @author Simon Toens on 11/30/14

#import <Foundation/Foundation.h>

/**
 * Abstract base assertion exception.
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
