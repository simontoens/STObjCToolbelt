// @author Simon Toens 01/03/13

#import <Foundation/Foundation.h>

/**
 * Simple Varint encoding/decoding: http://developers.google.com/protocol-buffers/docs/encoding#varints
 * 
 * Currently only positive numbers are suported.
 */
@interface VarintCoder : NSObject

- (id)init;
- (id)initWithNumBits:(NSUInteger)aNumBits;

- (NSData *)encode:(NSUInteger)value;
- (void)encode:(NSUInteger)value into:(NSMutableData *)data;

- (NSUInteger)decode:(NSData *)data;

@end