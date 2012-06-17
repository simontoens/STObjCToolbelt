//  Created by Simon Toens on 6/16/12.

#import "STXmlBuilder.h"

@interface STXmlBuilder()
@property (nonatomic, strong) NSMutableArray *elementStack;
@property (nonatomic, strong, readwrite) NSMutableString *xml;
- (void)indent;
- (void)write:(NSString *)elementName attributes:(NSDictionary *)attributes;
@end

@implementation STXmlBuilder

@synthesize elementStack;
@synthesize xml;

- (id)init {
    if (self = [super init]) {
        elementStack = [[NSMutableArray alloc] init];
        xml = [[NSMutableString alloc] init];
        [xml appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"];
    }
    return self;
}

- (STXmlBuilder *)addElement:(NSString *)elementName {
    [self write:elementName attributes:nil];
    return self;
}

- (STXmlBuilder *)addElement:(NSString *)elementName attributes:(NSDictionary *)attributes {
    [self write:elementName attributes:attributes];
    return self;
}

- (STXmlBuilder *)closeElement {
    NSString *elementName = [elementStack lastObject];
    [elementStack removeLastObject];
    [self indent];
    [xml appendFormat:@"</%@>\n", elementName];
    return self;
}

- (STXmlBuilder *)closeAllElements {
    while ([elementStack count] > 0) {
        [self closeElement];
    }
    return self;
}

- (void)write:(NSString *)elementName attributes:(NSDictionary *)attributes {
    [self indent];
    [xml appendFormat:@"<%@", elementName];
    if (attributes) {
        for (NSString *attrName in [attributes allKeys]) {
            [xml appendString:@" "];
            [xml appendFormat:@"%@=%@", attrName, [attributes objectForKey:attrName]];
        }
    }
    [xml appendString:@">\n"];
    [elementStack addObject:elementName];
}

- (void)indent {
    for (NSString *element in elementStack) {
        [xml appendString:@"  "];
    }
}

- (NSString *)description {
    return xml;    
}

@end
