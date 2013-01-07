// @author Simon Toens 01/03/13

#import <Foundation/Foundation.h>

/**
 * Simple Varint encoding/decoding: http://developers.google.com/protocol-buffers/docs/encoding#varints
 * 
 * Currently only positive numbers are suported.
 */
@interface VarintCoder : NSObject

- (id)init;

/**
 * Encode the specified value.
 */
- (NSData *)encode:(NSUInteger)value;

/**
 * Encode the specified value and append the bytes to the specified data.
 */
- (void)encode:(NSUInteger)value into:(NSMutableData *)data;

/**
 * Decodes the specified data, previously encoded using encode, back to a NSUInteger.
 *
 * It is possible to call this method multiple times with incomplete NSData instances - the final decode call
 * will return the decoded value.  Use the doneDecoding argument to determine if decoding is complete.
 *
 * @param data  The bytes to decode, previously encoded using the encode method in this class
 * @param numBytesDecodedDecoded  The number of bytes that have been decoded
 * @param doneDecoding  Whether the decoding is complete
 * @return The decoded value, or 0 if the decoding is not doneDecoding yet.
 */
- (NSUInteger)decode:(NSData *)data numBytesDecoded:(NSUInteger *)numBytesDecoded doneDecoding:(BOOL *)doneDecoding;

/**
 * How many bits to use per byte.  Defaults to 8.  Useful for testing.
 */
@property (nonatomic) uint8_t numBitsPerByte;

@end