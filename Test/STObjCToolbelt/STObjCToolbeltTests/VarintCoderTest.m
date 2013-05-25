// @author Simon Toens 01/05/13

#import <limits.h>
#import <SenTestingKit/SenTestingKit.h>
#import "VarintCoder.h"

@interface VarintCoderTest : SenTestCase

@end

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
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    [self assertData:[c encode:0] expectedLength:1 expectedValues:(int[]){0} expectedNumBits:2];
    [self assertData:[c encode:1] expectedLength:1 expectedValues:(int[]){1} expectedNumBits:2];
}

- (void)testEncodeMultipleBytes {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;

    [self assertData:[c encode:-1] expectedLength:2 expectedValues:(int[]){0, 1} expectedNumBits:2];

    [self assertData:[c encode:2] expectedLength:2 expectedValues:(int[]){1, 1} expectedNumBits:2];    
    [self assertData:[c encode:-2] expectedLength:3 expectedValues:(int[]){0, 0, 1} expectedNumBits:2];
    
    [self assertData:[c encode:3] expectedLength:3 expectedValues:(int[]){1, 0, 1} expectedNumBits:2];
    [self assertData:[c encode:-3] expectedLength:3 expectedValues:(int[]){0, 1, 1} expectedNumBits:2];

    [self assertData:[c encode:4] expectedLength:3 expectedValues:(int[]){1, 1, 1} expectedNumBits:2];
    [self assertData:[c encode:-4] expectedLength:4 expectedValues:(int[]){0, 0, 0, 1} expectedNumBits:2];
    
    [self assertData:[c encode:5] expectedLength:4 expectedValues:(int[]){1, 0, 0, 1} expectedNumBits:2];
    [self assertData:[c encode:-5] expectedLength:4 expectedValues:(int[]){0, 1, 0, 1} expectedNumBits:2];
}

- (void)testDecodeSingleByte {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    
    STAssertEquals([c decode:[c encode:0]], 0, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:1]], 1, @"Bad decoded value");
}

- (void)testDecodeMultipleBytes {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    
    STAssertEquals([c decode:[c encode:2]], 2, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:3]], 3, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:4]], 4, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:-4]], -4, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:5]],  5, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:-5]], -5, @"Bad decoded value");
    STAssertEquals([c decode:[c encode:8]], 8, @"Bad decoded value");    
    STAssertEquals([c decode:[c encode:-8]], -8, @"Bad decoded value");
}

- (void)testDecodeMultipleBytesWithGarbageAtEndOfNSData {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    
    NSMutableData *data = [NSMutableData dataWithData:[c encode:10]];
    uint8_t garbage[] = {122, 20, 10, 22};
    [data appendBytes:garbage length:4];
    STAssertEquals([c decode:data], 10, @"Bad decoded value");    
}

- (void)testDecodeLargeValue {
    VarintCoder *c = [[VarintCoder alloc] init];
    int val = 2000001;
    STAssertEquals([c decode:[c encode:val]], val, @"Bad decoded value");
}

- (void)testCountNumBytesDecoded {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    NSUInteger numBytesDecoded = 0;
    [c decode:[c encode:8] offset:0 numBytesDecoded:&numBytesDecoded doneDecoding:NULL];
    STAssertEquals(numBytesDecoded, (NSUInteger)4, @"Bad decoded byte count");
}

- (void)testDoneDecoding {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    NSUInteger value = 8;
    NSData *data = [c encode:value];
    STAssertEquals([data length], (NSUInteger)4, @"Unexpected length");
    const uint8_t *bytes = [data bytes];
    for (int i = 0; i < [data length] - 1; i++) {
        NSUInteger numBytesDecoded = 0;
        BOOL doneDecoding = NO;
        NSData *singleByte = [NSData dataWithBytesNoCopy:(uint8_t[]){bytes[i]} length:1 freeWhenDone:NO];
        NSUInteger result = [c decode:singleByte offset:0 numBytesDecoded:&numBytesDecoded doneDecoding:&doneDecoding];
        STAssertEquals(result, (NSUInteger)0, @"Decoding not complete");
        STAssertEquals(numBytesDecoded, (NSUInteger)1, @"Bad numBytesDecoded");
        STAssertFalse(doneDecoding, @"Decoding not complete");
    }
    BOOL doneDecoding = NO;
    NSData *singleByte = [NSData dataWithBytesNoCopy:(uint8_t[]){bytes[3]} length:1 freeWhenDone:NO];
    NSUInteger result = [c decode:singleByte offset:0 numBytesDecoded:NULL doneDecoding:&doneDecoding];
    STAssertEquals(result, value, @"Bad decoded value");
    STAssertTrue(doneDecoding, @"Decoding complete");    
}

- (void)testOffset {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;

    NSUInteger numBytesDecoded = 0;
    BOOL done = NO;
    NSMutableData *encodedData = [NSMutableData dataWithData:[c encode:8]];
    uint8_t garbage[] = {122, 20, 10, 22};
    NSMutableData *data = [NSMutableData data];
    [data appendBytes:garbage length:4];
    [data appendData:encodedData];
    [data appendBytes:garbage length:4];
    STAssertEquals([c decode:data offset:4 numBytesDecoded:&numBytesDecoded doneDecoding:&done], 8, @"Bad decoded value");
    STAssertEquals(numBytesDecoded, (NSUInteger)4, @"Bad numBytesDecoded");
    STAssertTrue(done, @"Expected decode to be done");
}

- (void)testDefaultNumBitsPerByte {
    VarintCoder *c = [[VarintCoder alloc] init];
    STAssertEquals(c.numBitsPerByte, (uint8_t)7, @"Expected default of 7 usable bits per byte");
}

@end