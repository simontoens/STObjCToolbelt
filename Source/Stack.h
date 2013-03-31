// @author Simon Toens 10/03/10

#import <Foundation/Foundation.h>

@interface Stack : NSObject

/**
 * Push thing onto the stack.  Pushing nil is not allowed.
 */
- (void)push:(id)thing;

/**
 * Pop the topmost item off the stack.  Returns nil if the stack is empty.
 */
- (id)pop;

/**
 * Return the item on top of the stack without removing it.  Returns nil if the stack is empty.
 */
- (id)peak;

@property(nonatomic, readonly) BOOL empty;
@property(nonatomic, readonly) NSUInteger count;

@end