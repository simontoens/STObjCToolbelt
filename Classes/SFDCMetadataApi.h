//  Created by Simon Toens on 6/19/12.

#import <Foundation/Foundation.h>
#import "MultiDictionary.h"

@interface SFDCMetadataApi : NSObject

- (NSData *)retrieveUnpackaged:(MultiDictionary *)packageTypes;

@end
