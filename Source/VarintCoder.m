// @author Simon Toens 01/03/13

#import "Preconditions.h"
#import "VarintCoder.h"

@interface VarintCoder() {
@private
    NSUInteger byteRead;
    NSInteger decodingInProgressValue;
}
@end

@implementation VarintCoder

@synthesize numBitsPerByte = _numBitsPerByte;

#pragma mark - Public methods

- (id)init {
    if (self = [super init]) {
        byteRead = 0;
        decodingInProgressValue = 0;
        _numBitsPerByte = 7;
    }
    return self;
}

- (NSData *)encode:(NSInteger)value {
    NSMutableData *data = [[NSMutableData alloc] init]; // actually init with right size?
    [self encode:value into:data];
    return data;
}

- (void)encode:(NSInteger)value into:(NSMutableData *)data {
    
    value = [self zigzagEncode:value];
    
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

- (NSInteger)decode:(NSData *)data 
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
        if (byteValue & (1 << self.numBitsPerByte)) {
            lastByte = NO;
            byteValue &= (1 << self.numBitsPerByte) - 1;
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
            NSInteger rtn = decodingInProgressValue;
            decodingInProgressValue = 0;
            byteRead = 0;
            return [self zigzagDecode:rtn];
        }
    }
    return 0;
}

- (NSInteger)decode:(NSData *)data {
    return [self decode:data offset:0 numBytesDecoded:NULL doneDecoding:NULL];
}

#pragma mark - Properties

- (void)setNumBitsPerByte:(uint8_t)aNumBitsPerByte {
    // since we always use a full byte, it is a waste to set this to less than 8
    // however, it is useful for testing
    [Preconditions assert:aNumBitsPerByte >= 2 message:@"Must at least have 2 bits"];
    [Preconditions assert:aNumBitsPerByte <= 8 message:@"Must at most have 8 bits"];
    _numBitsPerByte = aNumBitsPerByte - 1; // leftmost bit is reserved
}

#pragma mark - Private methods

- (NSInteger)zigzagEncode:(NSInteger)value {
    if (value < 0) {
        return -value * 2;
    } else if (value > 0) {
        return (value * 2) - 1;
    }
    return 0;
}

- (NSInteger)zigzagDecode:(NSInteger)value {
    if ((value % 2) == 0) {
        return -(value / 2);
    } else {
        return (value + 1) / 2;
    }
}

@end