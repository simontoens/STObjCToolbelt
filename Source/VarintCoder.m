// @author Simon Toens 01/03/13

#import "Preconditions.h"
#import "VarintCoder.h"

@implementation VarintCoder

@synthesize numBitsPerByte;

- (id)init {
    if (self = [super init]) {
        self.numBitsPerByte = 8;
    }
    return self;
}

- (NSData *)encode:(NSUInteger)value {
    NSMutableData *data = [[NSMutableData alloc] init]; // actually init with right size
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

- (NSUInteger)decode:(NSData *)data numBytes:(NSUInteger *)numBytes {
    int value = 0;
    const uint8_t *bytes = [data bytes];
    for (int i = 0; i < [data length]; i++) {
        uint8_t byteValue = bytes[i];
        BOOL lastByte = YES;
        if (byteValue & (1 << numBitsPerByte)) {
            lastByte = NO;
            byteValue &= (1 << numBitsPerByte) - 1;
        }
        
        // bytes are in order of least significant byte
        int multiplier = 1 << (i * self.numBitsPerByte);
        
        value += multiplier * byteValue;
        if (lastByte) {
            if (numBytes) {
                *numBytes = i + 1;
            }
            break;
        }
    }
    return value;
}

- (void)setNumBitsPerByte:(uint8_t)aNumBitsPerByte {
    // since we always use a full byte, it is a waste to use less tha
    [Preconditions assertArg:@"Must have at least 2 bits" condition:aNumBitsPerByte >= 2];
    [Preconditions assertArg:@"Must have at most 8 bits" condition:aNumBitsPerByte <= 8];
    numBitsPerByte = aNumBitsPerByte - 1; // leftmost bit is reserved
}

@end