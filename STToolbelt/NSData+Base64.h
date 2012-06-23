//  Created by Simon Toens on 6/19/12.

#import <Foundation/Foundation.h>

// Code taken from http://stackoverflow.com/questions/392464/any-base64-library-on-iphone-sdk
@interface NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)strBase64;
- (NSString *)getBase64EncodedString;

@end
