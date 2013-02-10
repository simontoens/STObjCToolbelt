// @author Simon Toens 6/19/12

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface NSData (Encoding)

+ (NSData *)dataWithBase64EncodedString:(NSString *)strBase64;
- (NSString *)toBase64Encoding;

- (NSString *)toMD5;

@end