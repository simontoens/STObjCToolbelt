// @author Simon Toens 01/03/13

#import <Foundation/Foundation.h>

/**
 * Simple Varint encoding/decoding: http://developers.google.com/protocol-buffers/docs/encoding#varints
 * 
 * Currently only positive numbers are suported.
 */
@interface VarintCoder : NSObject

- (id)init;

- (NSData *)encode:(NSUInteger)value;
- (void)encode:(NSUInteger)value into:(NSMutableData *)data;

- (NSUInteger)decode:(NSData *)data numBytes:(NSUInteger *)numBytes;

/**
 * How many bits to use per byte.  Defaults to 8.  Useful for testing.
 */
@property (nonatomic) uint8_t numBitsPerByte;

@end