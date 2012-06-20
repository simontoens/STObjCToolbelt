//  Created by Simon Toens on 6/18/12.

#import "SFDCMetadataSoapEnvelopeBuilder.h"

@interface SFDCMetadataSoapEnvelopeBuilder()
@property (nonatomic, strong) XmlBuilder *xmlBuilder;
@property (nonatomic, strong) NSString* sessionId;
- (void)addBodyElement;
- (void)addCheckStatusBody:(NSString *)rootElement asyncId:(NSString *)asyncId;
- (void)addHeader;
- (void)addRetrieveBody:(MultiDictionary *)packageTypes;
- (NSString *)buildCheckStatusMessage:(NSString *)checkStatusElementName asyncId:(NSString *)asyncId;
- (void)startNewMessage;
@end

@implementation SFDCMetadataSoapEnvelopeBuilder

static NSString* const kSoapNamespace = @"http://schemas.xmlsoap.org/soap/envelope";
static NSString* const kMetadataNamespace = @"http://soap.sforce.com/2006/04/metadata";

@synthesize apiVersion;
@synthesize sessionId;
@synthesize xmlBuilder;

- (id)initWithSessionId:(NSString *)aSessionId {
    if (self = [super init]) {
        sessionId = aSessionId;
        apiVersion = @"26.0";
    }
    return self;
}

- (NSString *)getUnpackagedRetrieveMessage:(MultiDictionary *)packageTypes {
    [self startNewMessage];
    [self addHeader];
    [self addRetrieveBody:(MultiDictionary *)packageTypes];
    [xmlBuilder closeElement];
    return xmlBuilder.xml;
}

- (NSString *)getCheckStatusMessage:(NSString *)asyncId {
    return [self buildCheckStatusMessage:@"checkStatus" asyncId:asyncId];
}

- (NSString *)getCheckRetrieveStatusMessage:(NSString *)asyncId {
    return [self buildCheckStatusMessage:@"checkRetrieveStatus" asyncId:asyncId];
}

- (NSString *)buildCheckStatusMessage:(NSString *)checkStatusElementName asyncId:(NSString *)asyncId {
    [self startNewMessage];
    [self addHeader];
    [self addCheckStatusBody:checkStatusElementName asyncId:asyncId];
    [xmlBuilder closeElement];
    return xmlBuilder.xml;    
}

- (void)startNewMessage {
    xmlBuilder = [[XmlBuilder alloc] init];
    xmlBuilder.prettyPrint = NO;
    [xmlBuilder addElement:@"Envelope" attributes:[NSArray arrayWithObjects:@"xmlns", kSoapNamespace, nil]];    
}

- (void)addHeader {
    [xmlBuilder mark];
    [xmlBuilder addElement:@"Header"];
    [xmlBuilder addElement:@"SessionHeader" attributes:[NSArray arrayWithObjects:@"xmlns", kMetadataNamespace, nil]];
    [xmlBuilder addElement:@"SessionId"];
    [xmlBuilder addValue:sessionId];
    [xmlBuilder closeElementsUntilMark];
}

- (void)addBodyElement {
    [xmlBuilder addElement:@"Body"];    
}

- (void)addCheckStatusBody:(NSString *)rootElement asyncId:(NSString *)asyncId {
    [xmlBuilder mark];
    [self addBodyElement];
    [xmlBuilder addElement:rootElement attributes:[NSArray arrayWithObjects:@"xmlns", kMetadataNamespace, nil]];
    [xmlBuilder addElement:@"asyncProcessId" value:asyncId];
    [xmlBuilder closeElementsUntilMark];
}

- (void)addRetrieveBody:(MultiDictionary *)packageTypes {
    [xmlBuilder mark];
    [self addBodyElement];
    [xmlBuilder addElement:@"retrieve" attributes:[NSArray arrayWithObjects:@"xmlns", kMetadataNamespace, nil]];
    [xmlBuilder addElement:@"retrieveRequest"];
    [xmlBuilder addElement:@"apiVersion" value:apiVersion];
    [xmlBuilder addElement:@"singlePackage" value:@"false"];
    [xmlBuilder addElement:@"unpackaged"];
    
    for (NSString *entityApiName in [packageTypes allKeys]) {
        [xmlBuilder addElement:@"types"];
        NSMutableString* members = [[NSMutableString alloc] init];
        for (NSString* member in [packageTypes objectsForKey:entityApiName]) {
            [members appendString:member];
            [members appendString:@" "];
        }
        [xmlBuilder addElement:@"members" value:members];
        [xmlBuilder addElement:@"name" value:entityApiName];
    }
    [xmlBuilder closeElementsUntilMark];
}

@end