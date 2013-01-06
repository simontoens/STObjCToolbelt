// @author Simon Toens 01/05/13

#import "VarintCoder.h"
#import "VarintCoderTest.h"

@implementation VarintCoderTest

- (void)assertData:(NSData *)data expectedLength:(int)expectedLength expectedValues:(int[])expectedValues {
    STAssertEquals([data length], (NSUInteger)expectedLength, @"Unexpected data length");
    const uint8_t *bytes = [data bytes];
    for (uint8_t i = 0; i < expectedLength; i++) {
        STAssertEquals(bytes[i], (uint8_t)expectedValues[i], @"Unexpected data value for byte at %i", i);        
    }
}

- (void)testEncodeSingleByte {
    VarintCoder *c = [[VarintCoder alloc] initWithNumBits:2];
    
    [self assertData:[c encode:0] expectedLength:1 expectedValues:(int[]){0}];
    [self assertData:[c encode:1] expectedLength:1 expectedValues:(int[]){1}];
    [self assertData:[c encode:2] expectedLength:1 expectedValues:(int[]){2}];
    [self assertData:[c encode:3] expectedLength:1 expectedValues:(int[]){3}];
}

- (void)testEncodeMultipleBytes {
    VarintCoder *c = [[VarintCoder alloc] initWithNumBits:2];

    [self assertData:[c encode:4] expectedLength:2 expectedValues:(int[]){1, 0}];
    [self assertData:[c encode:5] expectedLength:2 expectedValues:(int[]){1, 1}];
    [self assertData:[c encode:6] expectedLength:2 expectedValues:(int[]){1, 2}];
    [self assertData:[c encode:7] expectedLength:2 expectedValues:(int[]){1, 3}];
    [self assertData:[c encode:8] expectedLength:2 expectedValues:(int[]){2, 0}];
}

@end