//  Created by Simon Toens on 6/18/12.

#import <Foundation/Foundation.h>

#import "MultiDictionary.h"
#import "XmlBuilder.h"

@interface SFDCMetadataSoapEnvelopeBuilder : NSObject

- (id)initWithSessionId:(NSString *)sessionId;
- (NSString *)getUnpackagedRetrieveMessage:(MultiDictionary *)packageTypes;
- (NSString *)getCheckStatusMessage:(NSString *)asyncId;
- (NSString *)getCheckRetrieveStatusMessage:(NSString *)asyncId;

@property (nonatomic, strong) NSString *apiVersion;

@end
