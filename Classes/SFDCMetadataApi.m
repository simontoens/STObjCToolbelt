//  Created by Simon Toens on 6/19/12.

#import "SFDCMetadataApi.h"
#import "SFDCMetadataSoapEnvelopeBuilder.h"

@interface SFDCMetadataApi()
@property (nonatomic, strong) NSString *apiVersion;
@property (nonatomic, strong) SFDCMetadataSoapEnvelopeBuilder *soapMessageBuilder;
- (NSMutableURLRequest *)getRequestObject:(NSString *)body;
- (NSString *)makeRequest:(NSString *)body;
@end

@implementation SFDCMetadataApi

static NSString* const kApiEndpoint = @"https://na1.salesforce.com/services/Soap/m/";

@synthesize apiVersion;
@synthesize soapMessageBuilder;

- (id)initWithSessionId:(NSString *)sessionId apiVersion:(NSString *)anApiVersion {
    if (self = [super init]) {
        apiVersion = anApiVersion;
        soapMessageBuilder = [[SFDCMetadataSoapEnvelopeBuilder alloc] initWithSessionId:sessionId];
    }
    return self;
}

- (NSData *)retrieveUnpackaged:(MultiDictionary *)packageTypes {
    NSString *unpackagedRetrieveMessage = [soapMessageBuilder getUnpackagedRetrieveMessage:packageTypes];
    NSLog(@"%@", unpackagedRetrieveMessage);
    
    NSString* respone = [self makeRequest:unpackagedRetrieveMessage];
    
    NSLog(@"response: %@", respone);
    
    return nil;
}

- (NSString *)makeRequest:(NSString *)body {
    NSURLRequest *request = [self getRequestObject:body];
    
    NSURLResponse *resp = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&error];
    
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}

- (NSMutableURLRequest *)getRequestObject:(NSString *)body {
    NSString *url = [NSString stringWithFormat:@"%@%@", kApiEndpoint, apiVersion];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"\"\"" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

@end
