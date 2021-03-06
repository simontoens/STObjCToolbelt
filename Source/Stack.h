// @author Simon Toens 10/03/10

#import <Foundation/Foundation.h>

@interface Stack : NSObject <NSCopying>

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
- (id)peek;

/**
 * Return a read-only array containg all items in the stack.  The first item in the array is the 
 * deepest item in the stack.
 */
- (NSArray *)allObjects;

@property(nonatomic, readonly) BOOL empty;
@property(nonatomic, readonly) NSUInteger count;

@end