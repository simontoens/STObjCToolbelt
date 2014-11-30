// @author Simon Toens on 11/30/14

#import <Foundation/Foundation.h>

/**
 * An Exception hierarchy that represents assertion errors, ie non-user handable conditions that are not expected to occur.
 *
 * Assertion is the abstract root type in this hierarchy.
 */
@interface Assertion : NSException

- (instancetype)init __unavailable;

- (instancetype)initWithReason:(NSString *)reason;

@end

/**
 * A generic assertion thrown when an unexpected condition is detected.
 * For example, when the end of an if/else-if chain is reached: if the programmmer expected one of the
 * if/else-if conditions to evaluate to true, then the final 'else' throws this assertion.
 */
@interface IllegalStateAssertion : Assertion
+ (instancetype)withReason:(NSString *)reason;
- (instancetype)init __unavailable;
@end

/**
 * Thrown by abstract method implementations (ie what could happen at compile-time if ObjectiveC had 'abstract').
 */
@interface AbstractMethodAssertion : Assertion
+ (instancetype)forSelector:(SEL)selector;
- (instancetype)init __unavailable;
@end

/**
 * Thrown at the very beginning of a method when argument values to not match the methods expectation.
 */
@interface IllegalArgumentAssertion : Assertion
+ (instancetype)withReason:(NSString *)reason;
- (instancetype)init __unavailable;
@end

