// @author Simon Toens 6/19/12

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)strBase64;
- (NSString *)getBase64EncodedString;

@end