// @author Simon Toens 01/05/13

#import <limits.h>
#import <XCTest/XCTest.h>
#import "VarintCoder.h"

@interface VarintCoderTest : XCTestCase
@end

@implementation VarintCoderTest

- (void)assertData:(NSData *)data 
    expectedLength:(int)expectedLength 
    expectedValues:(int[])expectedValues 
   expectedNumBits:(int)expectedNumBits 
{
    XCTAssertEqual([data length], (NSUInteger)expectedLength, @"Unexpected data length");
    const uint8_t *bytes = [data bytes];
    for (uint8_t i = 0; i < expectedLength; i++) {
        uint8_t value = bytes[i];
        if (i < (expectedLength - 1)) {
            XCTAssertTrue(value & 1 << (expectedNumBits - 1), @"Expected leftmost bit to be on");
            value &= (1 << ((expectedNumBits - 1) - 1));
        }
        XCTAssertEqual(value, (uint8_t)expectedValues[i], @"Unexpected data value for byte at %i", i);        
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
    
    XCTAssertEqual([c decode:[c encode:0]], 0, @"Bad decoded value");
    XCTAssertEqual([c decode:[c encode:1]], 1, @"Bad decoded value");
}

- (void)testDecodeMultipleBytes {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    
    XCTAssertEqual([c decode:[c encode:2]], 2, @"Bad decoded value");
    XCTAssertEqual([c decode:[c encode:3]], 3, @"Bad decoded value");
    XCTAssertEqual([c decode:[c encode:4]], 4, @"Bad decoded value");
    XCTAssertEqual([c decode:[c encode:-4]], -4, @"Bad decoded value");
    XCTAssertEqual([c decode:[c encode:5]],  5, @"Bad decoded value");
    XCTAssertEqual([c decode:[c encode:-5]], -5, @"Bad decoded value");
    XCTAssertEqual([c decode:[c encode:8]], 8, @"Bad decoded value");    
    XCTAssertEqual([c decode:[c encode:-8]], -8, @"Bad decoded value");
}

- (void)testDecodeMultipleBytesWithGarbageAtEndOfNSData {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    
    NSMutableData *data = [NSMutableData dataWithData:[c encode:10]];
    uint8_t garbage[] = {122, 20, 10, 22};
    [data appendBytes:garbage length:4];
    XCTAssertEqual([c decode:data], 10, @"Bad decoded value");    
}

- (void)testDecodeLargeValue {
    VarintCoder *c = [[VarintCoder alloc] init];
    int val = 2000001;
    XCTAssertEqual([c decode:[c encode:val]], val, @"Bad decoded value");
}

- (void)testCountNumBytesDecoded {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    NSUInteger numBytesDecoded = 0;
    [c decode:[c encode:8] offset:0 numBytesDecoded:&numBytesDecoded doneDecoding:NULL];
    XCTAssertEqual(numBytesDecoded, (NSUInteger)4, @"Bad decoded byte count");
}

- (void)testDoneDecoding {
    VarintCoder *c = [[VarintCoder alloc] init];
    c.numBitsPerByte = 2;
    NSInteger value = 8;
    NSData *data = [c encode:value];
    XCTAssertEqual([data length], (NSUInteger)4, @"Unexpected length");
    const uint8_t *bytes = [data bytes];
    for (NSUInteger i = 0; i < [data length] - 1; i++) {
        NSUInteger numBytesDecoded = 0;
        BOOL doneDecoding = NO;
        NSData *singleByte = [NSData dataWithBytesNoCopy:(uint8_t[]){bytes[i]} length:1 freeWhenDone:NO];
        NSInteger result = [c decode:singleByte offset:0 numBytesDecoded:&numBytesDecoded doneDecoding:&doneDecoding];
        XCTAssertEqual(result, (NSInteger)0, @"Decoding not complete");
        XCTAssertEqual(numBytesDecoded, (NSUInteger)1, @"Bad numBytesDecoded");
        XCTAssertFalse(doneDecoding, @"Decoding not complete");
    }
    BOOL doneDecoding = NO;
    NSData *singleByte = [NSData dataWithBytesNoCopy:(uint8_t[]){bytes[3]} length:1 freeWhenDone:NO];
    NSInteger result = [c decode:singleByte offset:0 numBytesDecoded:NULL doneDecoding:&doneDecoding];
    XCTAssertEqual(result, value, @"Bad decoded value");
    XCTAssertTrue(doneDecoding, @"Decoding complete");    
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
    XCTAssertEqual([c decode:data offset:4 numBytesDecoded:&numBytesDecoded doneDecoding:&done], 8, @"Bad decoded value");
    XCTAssertEqual(numBytesDecoded, (NSUInteger)4, @"Bad numBytesDecoded");
    XCTAssertTrue(done, @"Expected decode to be done");
}

- (void)testDefaultNumBitsPerByte {
    VarintCoder *c = [[VarintCoder alloc] init];
    XCTAssertEqual(c.numBitsPerByte, (uint8_t)7, @"Expected default of 7 usable bits per byte");
}

@end