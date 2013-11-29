// @author Simon Toens 01/05/13

#import <Foundation/Foundation.h>

@interface Preconditions : NSObject

+ (void)assertNotNil:(id)thing;
+ (void)assertNotNil:(id)thing message:(NSString *)message;
+ (void)assertNotEmpty:(id)collection;
+ (void)assertNotEmpty:(id)collection message:(NSString *)message;
+ (void)fail:(NSString *)message;
+ (void)assert:(BOOL)condition message:(NSString *)message;

@end