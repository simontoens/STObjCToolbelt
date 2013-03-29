// @author Simon Toens 01/05/13

#import <Foundation/Foundation.h>

@interface Preconditions : NSObject

+ (void)assertArg:(NSString *)message condition:(BOOL)condition;
+ (void)assertNotNil:(id)thing;
+ (void)assertNotEmpty:(id)collection;

@end