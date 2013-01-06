// @author Simon Toens 01/03/13

#import <Foundation/Foundation.h>

@interface VarintCoder : NSObject

- (id)init;
- (id)initWithNumBits:(NSUInteger)aNumBits;

- (NSData *)encode:(NSUInteger)value;
- (void)encode:(NSUInteger)value into:(NSMutableData *)data;

@end