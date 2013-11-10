// @author Simon Toens 2/10/13

#import <SenTestingKit/SenTestingKit.h>
#import "NSData+Encoding.h"

@interface NSData_EncodingTest : SenTestCase
@end

@implementation NSData_EncodingTest

- (void)testBase64Encoding 
{
    unsigned char bytes[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    NSData *data = [NSData dataWithBytes:bytes length:10];
    
    NSString *encoded = [data toBase64Encoding];
    data = [NSData dataWithBase64EncodedString:encoded];
    
    for (int i = 0; i < 10; i++) {
        STAssertEquals(bytes[i], ((unsigned char*)data.bytes)[i], @"Bad byte");
    }
}

- (void)testMD5
{
    unsigned char bytes[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    NSData *data = [NSData dataWithBytes:bytes length:10];
    
    STAssertEqualObjects([data toMD5], [data toMD5], @"Expected equal MD5 string");
    
    NSData *data2 = [NSData dataWithBytes:bytes length:9];
    STAssertFalse([data isEqual:data2], @"Did not expected MD5 strings to be equal");
}

@end