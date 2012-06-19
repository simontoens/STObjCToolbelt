//  Created by Simon Toens on 6/18/12.

#import "STSoapEnvelopeBuilder.h"

@interface STSoapEnvelopeBuilder()
@property (nonatomic, strong, readwrite) STXmlBuilder *xmlBuilder;
@end

@implementation STSoapEnvelopeBuilder

@synthesize xmlBuilder;

- (id)init {
    if (self = [super init]) {
        xmlBuilder = [[STXmlBuilder alloc] init];
        xmlBuilder.prettyPrint = NO;
        [xmlBuilder addElement:@"Envelope" attributes:[NSArray arrayWithObjects:@"xmlns", @"http://schemas.xmlsoap.org/soap/envelope", nil]];
    }
    return self;
}

- (void)addHeader:(NSString *)sessionHeaderNamespace sessionId:(NSString *)sessionId {
    [xmlBuilder addElement:@"Header"];
    [xmlBuilder addElement:@"SessionHeader" attributes:[NSArray arrayWithObjects:@"xmlns", sessionHeaderNamespace, nil]];
    [xmlBuilder addElement:@"SessionId"];
    [xmlBuilder addValue:sessionId];
    [xmlBuilder closeElement];
    [xmlBuilder closeElement];
    [xmlBuilder closeElement];
}

- (void)addBody {
    [xmlBuilder addElement:@"Body"];
}

@end
