// @author Simon Toens 01/03/13

#import "Preconditions.h"
#import "VarintCoder.h"

@interface VarintCoder() {
@private
    NSInteger numBitsInGroup;
}
@end

@implementation VarintCoder

- (id)init {
    return [self initWithNumBits:8];
}

- (id)initWithNumBits:(NSUInteger)aNumBitsInGroup {
    if (self = [super init]) {
        // note: since we always use a full byte, it is a waste to use less than 8 bits
        [Preconditions assertArg:@"Must have at least 2 bits" condition:aNumBitsInGroup >= 2];
        [Preconditions assertArg:@"Must have at most 8 bits" condition:aNumBitsInGroup <= 8];

        numBitsInGroup = aNumBitsInGroup - 1; // leftmost bit is reserved
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
    
    int numBitGroups = bitsRequired / numBitsInGroup;
    
    if ((bitsRequired % numBitsInGroup != 0)) {
        numBitGroups += 1;
    }
    
    int currentBitGroup = numBitGroups;
    
    uint8_t bytes[numBitGroups];
    
    while (currentBitGroup > 0) {
        
        int divisor = 1 << ((currentBitGroup - 1) * numBitsInGroup);
        
        // write in order of least significant byte to make decoding easier
        int bitGroupIndex = currentBitGroup - 1;
        
        bytes[bitGroupIndex] = value / divisor;
        
        if (bitGroupIndex < (numBitGroups - 1)) {
            bytes[bitGroupIndex] |= 1 << numBitsInGroup;
        }
                
        value = value % divisor;
        
        currentBitGroup -= 1;
    }
    
    [data appendData:[NSData dataWithBytes:(void *)bytes length:numBitGroups]];
}

- (NSUInteger)decode:(NSData *)data {
    int value = 0;
    const uint8_t *bytes = [data bytes];
    for (int i = 0; i < [data length]; i++) {
        uint8_t byteValue = bytes[i];
        BOOL lastByte = YES;
        if (byteValue & (1 << numBitsInGroup)) {
            lastByte = NO;
            byteValue &= (1 << numBitsInGroup) - 1;
        }
        
        // bytes are in order of least significant byte
        int multiplier = 1 << (i * numBitsInGroup);
        
        value += multiplier * byteValue;
        if (lastByte) {
            break;
        }
    }
    return value;
}

@end