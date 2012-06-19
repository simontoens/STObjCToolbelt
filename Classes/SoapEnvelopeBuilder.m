//  Created by Simon Toens on 6/18/12.

#import "SoapEnvelopeBuilder.h"

@interface SoapEnvelopeBuilder()
@property (nonatomic, strong, readwrite) XmlBuilder *xmlBuilder;
@end

@implementation SoapEnvelopeBuilder

@synthesize xmlBuilder;

- (id)init {
    if (self = [super init]) {
        xmlBuilder = [[XmlBuilder alloc] init];
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
