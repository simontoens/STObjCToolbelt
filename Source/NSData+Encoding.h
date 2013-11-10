// @author Simon Toens 6/19/12
// @see http://stackoverflow.com/questions/392464/any-base64-library-on-iphone-sdk

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface NSData (Encoding)

+ (NSData *)dataWithBase64EncodedString:(NSString *)strBase64;
- (NSString *)toBase64Encoding;

- (NSString *)toMD5;

@end