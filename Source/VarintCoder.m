// @author Simon Toens 01/03/13

#import "Preconditions.h"
#import "VarintCoder.h"

@interface VarintCoder() {
@private
    NSUInteger byteRead;
    NSUInteger decodingInProgressValue;
}
@end

@implementation VarintCoder

@synthesize numBitsPerByte;

#pragma mark - Public methods

- (id)init {
    if (self = [super init]) {
        byteRead = 0;
        decodingInProgressValue = 0;
        self.numBitsPerByte = 8;
    }
    return self;
}

- (NSData *)encode:(NSUInteger)value {
    NSMutableData *data = [[NSMutableData alloc] init]; // actually init with right size?
    [self encode:value into:data];
    return data;
}

- (void)encode:(NSUInteger)value into:(NSMutableData *)data {
    int bitsRequired = 0;
    int val = value;
    do {
        val >>= 1;
        bitsRequired += 1;
    } while (val != 0);
    
    int numBitGroups = bitsRequired / self.numBitsPerByte;
    
    if ((bitsRequired % self.numBitsPerByte != 0)) {
        numBitGroups += 1;
    }
    
    int currentBitGroup = numBitGroups;
    
    uint8_t bytes[numBitGroups];
    
    while (currentBitGroup > 0) {
        
        int divisor = 1 << ((currentBitGroup - 1) * self.numBitsPerByte);
        
        // write in order of least significant byte to make decoding easier
        int bitGroupIndex = currentBitGroup - 1;
        
        bytes[bitGroupIndex] = value / divisor;
        
        if (bitGroupIndex < (numBitGroups - 1)) {
            bytes[bitGroupIndex] |= 1 << self.numBitsPerByte;
        }
                
        value = value % divisor;
        
        currentBitGroup -= 1;
    }
    
    [data appendData:[NSData dataWithBytes:(void *)bytes length:numBitGroups]];
}

- (NSUInteger)decode:(NSData *)data 
              offset:(NSUInteger)offset 
     numBytesDecoded:(NSUInteger *)numBytesDecoded 
        doneDecoding:(BOOL *)doneDecoding 
{
    const uint8_t *bytes = [data bytes];
    
    if (numBytesDecoded) {
        *numBytesDecoded = 0;
    }
    
    if (doneDecoding) {
        *doneDecoding = NO;
    }
    for (int i = offset; i < [data length]; i++) {
        uint8_t byteValue = bytes[i];
        BOOL lastByte = YES;
        if (byteValue & (1 << numBitsPerByte)) {
            lastByte = NO;
            byteValue &= (1 << numBitsPerByte) - 1;
        }
        
        // bytes are in order of least significant byte
        int multiplier = 1 << (byteRead * self.numBitsPerByte);
        byteRead += 1;
        
        decodingInProgressValue += multiplier * byteValue;
        
        if (numBytesDecoded) {
            *numBytesDecoded += 1;
        }
        
        if (lastByte) {
            if (doneDecoding) {
                *doneDecoding = YES;
            }
            NSUInteger rtn = decodingInProgressValue;
            decodingInProgressValue = 0;
            byteRead = 0;
            return rtn;
        }
    }
    return 0;
}

- (NSUInteger)decode:(NSData *)data {
    return [self decode:data offset:0 numBytesDecoded:NULL doneDecoding:NULL];
}

#pragma mark - Properties

- (void)setNumBitsPerByte:(uint8_t)aNumBitsPerByte {
    // since we always use a full byte, it is a waste to use less tha
    [Preconditions assertArg:@"Must have at least 2 bits" condition:aNumBitsPerByte >= 2];
    [Preconditions assertArg:@"Must have at most 8 bits" condition:aNumBitsPerByte <= 8];
    numBitsPerByte = aNumBitsPerByte - 1; // leftmost bit is reserved
}

@end