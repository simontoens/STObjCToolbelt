// @author Simon Toens 01/03/13

#import <Foundation/Foundation.h>

/**
 * Simple Varint encoding/decoding: http://developers.google.com/protocol-buffers/docs/encoding#varints
 */
@interface VarintCoder : NSObject

/**
 * Encode the specified value.
 */
- (NSData *)encode:(NSInteger)value;

/**
 * Encode the specified value and append the bytes to the specified data.
 */
- (void)encode:(NSInteger)value into:(NSMutableData *)data;

/**
 * Decodes the specified data, previously encoded using encode, back to a NSUInteger.
 *
 * It is possible to call this method multiple times on the same VarintCoder instance with incomplete NSData instances;
 * the final decode call will return the decoded value.  Use the doneDecoding argument to determine if decoding is complete.
 *
 * @param data  The bytes to decode, previously encoded using the encode method in this class
 * @param offset  The offset to use when indexing into data
 * @param numBytesDecoded  The number of bytes that have been decoded (returned)
 * @param doneDecoding  Whether the decoding is complete (returned)
 * @return The decoded value, or 0 if the decoding is not done yet.
 */
- (NSInteger)decode:(NSData *)data 
              offset:(NSUInteger)offset 
     numBytesDecoded:(NSUInteger *)numBytesDecoded 
        doneDecoding:(BOOL *)doneDecoding;

/**
 * Same as calling decode:data offset:0 numBytesDecoded:NULL doneDecoding:NULL.
 */
- (NSInteger)decode:(NSData *)data;

/**
 * How many bits to use per byte.  Defaults to 8.  Useful for testing.
 */
@property (nonatomic) uint8_t numBitsPerByte;

@end
