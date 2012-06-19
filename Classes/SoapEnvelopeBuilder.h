//  Created by Simon Toens on 6/18/12.

#import <Foundation/Foundation.h>

#import "XmlBuilder.h"

@interface SoapEnvelopeBuilder : NSObject

- (void)addHeader:(NSString *)sessionHeaderNamespace sessionId:(NSString *)sessionId;
- (void)addBody;

@property (nonatomic, strong, readonly) XmlBuilder *xmlBuilder;

@end
