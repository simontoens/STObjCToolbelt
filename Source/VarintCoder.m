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
        [Preconditions assertArg:@"Must have at least 2 bits" condition:aNumBitsInGroup >=2];
        numBitsInGroup = aNumBitsInGroup;
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
    
    NSLog(@"Bits required: %i", bitsRequired);
    NSLog(@"Bit groups of %i required: %i", numBitsInGroup, numBitGroups);
    

    uint8_t bytes[numBitGroups];
    
    int currentBitGroup = numBitGroups;
    
    while (currentBitGroup > 0) {
        int divisor = 1 << ((currentBitGroup - 1) * numBitsInGroup);
        bytes[numBitGroups - currentBitGroup] = value / divisor;
        NSLog(@"bit group: %i value: %i", currentBitGroup, bytes[numBitGroups - currentBitGroup]);
        value = value % divisor;
        currentBitGroup -= 1;
    }
    
    [data appendData:[NSData dataWithBytes:(void *)bytes length:numBitGroups]];
}

@end