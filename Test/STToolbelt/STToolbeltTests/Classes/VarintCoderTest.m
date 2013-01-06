// @author Simon Toens 01/05/13

#import <limits.h>
#import "VarintCoder.h"
#import "VarintCoderTest.h"

@implementation VarintCoderTest

- (void)assertData:(NSData *)data 
    expectedLength:(int)expectedLength 
    expectedValues:(int[])expectedValues 
   expectedNumBits:(int)expectedNumBits 
{
    STAssertEquals([data length], (NSUInteger)expectedLength, @"Unexpected data length");
    const uint8_t *bytes = [data bytes];
    for (uint8_t i = 0; i < expectedLength; i++) {
        uint8_t value = bytes[i];
        if (i < (expectedLength - 1)) {
            STAssertTrue(value & 1 << (expectedNumBits - 1), @"Expected leftmost bit to be on");
            value &= (1 << ((expectedNumBits - 1) - 1));
        }
        STAssertEquals(value, (uint8_t)expectedValues[i], @"Unexpected data value for byte at %i", i);        
    }
}

- (void)testEncodeSingleByte {
    VarintCoder *c = [[VarintCoder alloc] initWithNumBits:2];    
    [self assertData:[c encode:0] expectedLength:1 expectedValues:(int[]){0} expectedNumBits:2];
    [self assertData:[c encode:1] expectedLength:1 expectedValues:(int[]){1} expectedNumBits:2];
}

- (void)testEncodeMultipleBytes {
    VarintCoder *c = [[VarintCoder alloc] initWithNumBits:2];
    
    [self assertData:[c encode:2] expectedLength:2 expectedValues:(int[]){0, 1} expectedNumBits:2];
    [self assertData:[c encode:3] expectedLength:2 expectedValues:(int[]){1, 1} expectedNumBits:2];

    [self assertData:[c encode:4] expectedLength:3 expectedValues:(int[]){0, 0, 1} expectedNumBits:2];
    [self assertData:[c encode:5] expectedLength:3 expectedValues:(int[]){1, 0, 1} expectedNumBits:2];
    [self assertData:[c encode:6] expectedLength:3 expectedValues:(int[]){0, 1, 1} expectedNumBits:2];
    [self assertData:[c encode:7] expectedLength:3 expectedValues:(int[]){1, 1, 1} expectedNumBits:2];
    [self assertData:[c encode:8] expectedLength:4 expectedValues:(int[]){0, 0, 0, 1} expectedNumBits:2];
}

- (void)testDecodeSingleByte {
    VarintCoder *c = [[VarintCoder alloc] initWithNumBits:2];
    STAssertEquals([c decode:[c encode:0]], (NSUInteger)0, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:1]], (NSUInteger)1, @"Bad decoded value");
}

- (void)testDecodeMultipleBytes {
    VarintCoder *c = [[VarintCoder alloc] initWithNumBits:2];
    STAssertEquals([c decode:[c encode:2]], (NSUInteger)2, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:3]], (NSUInteger)3, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:4]], (NSUInteger)4, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:5]], (NSUInteger)5, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:8]], (NSUInteger)8, @"Bad decoded value");    
}

- (void)testDecodeMultipleBytesWithGarbageAtEndOfNSData {
    VarintCoder *c = [[VarintCoder alloc] initWithNumBits:2];
    NSMutableData *data = [NSMutableData dataWithData:[c encode:10]];
    uint8_t garbage[] = {122, 20, 10, 22};
    [data appendBytes:garbage length:4];
    STAssertEquals([c decode:data], (NSUInteger)10, @"Bad decoded value");    
}

- (void)testDecodeLargeValue {
    VarintCoder *c = [[VarintCoder alloc] init];
    int val = 2000001;
    STAssertEquals([c decode:[c encode:val]], (NSUInteger)val, @"Bad decoded value");
}

@end