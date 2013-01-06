// @author Simon Toens 6/16/12.

#import "XMLBuilder.h"

@interface XMLBuilder()
@property (nonatomic, assign) BOOL configured;
@property (nonatomic, strong) NSMutableArray *elementStack;
@property (nonatomic, strong) NSMutableArray *markStack;
@property (nonatomic, strong, readwrite) NSMutableString *xml;
- (void)eol;
- (void)indent;
- (void)configure;
- (void)write:(NSString *)elementName attributes:(NSArray *)attributes;
@end

@implementation XMLBuilder

@synthesize elementStack;

@synthesize configured;
@synthesize prettyPrint;
@synthesize markStack;
@synthesize xml;

- (id)init {
    if (self = [super init]) {
        elementStack = [[NSMutableArray alloc] init];
        markStack = [[NSMutableArray alloc] init];
        xml = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)addElement:(NSString *)elementName {
    [self write:elementName attributes:nil];
}

- (void)addElement:(NSString *)elementName attributes:(NSArray *)attributes {
    [self write:elementName attributes:attributes];
}

- (void)addElement:(NSString *)elementName value:(NSString *)value {
    [self write:elementName attributes:nil];
    [self addValue:value];
    [self closeElement];
}

- (void)addValue:(NSString *)value {
    [self indent];
    [xml appendString:value];
    [self eol];
}

- (void)closeElement {
    NSString *elementName = [elementStack lastObject];
    [elementStack removeLastObject];
    [self indent];
    [xml appendFormat:@"</%@>", elementName];
    [self eol];
}

- (void)closeAllElements {
    while ([elementStack count] > 0) {
        [self closeElement];
    }
}

- (void)mark {
    [markStack addObject:[NSNumber numberWithInt:[elementStack count]]];
}

- (void)closeElementsUntilMark {
    int elementCount = [elementStack count];
    int mark = [[markStack lastObject] intValue];
    [markStack removeLastObject];
    for (int i = mark; i < elementCount; i++) {
        [self closeElement];    
    }
}

- (void)write:(NSString *)elementName attributes:(NSArray *)attributes {
    if (!configured) {
        [self configure];
    }
    [self indent];
    [xml appendFormat:@"<%@", elementName];
    if (attributes) {
        for (int i = 0; i < [attributes count]; i+=2) {
            [xml appendString:@" "];
            [xml appendFormat:@"%@=\"%@\"", [attributes objectAtIndex:i], [attributes objectAtIndex:i+1]];
        }
    }
    [xml appendString:@">"];
    [self eol];
    [elementStack addObject:elementName];
}

- (void)indent {
    if (!prettyPrint) {
        return;
    }
    for (NSString *element in elementStack) {
        [xml appendString:@"  "];
    }
}

- (void)eol {
    if (!prettyPrint) {
        return;
    }
    [xml appendString:@"\n"];
}

- (void)configure {
    // add this before writing anything else
    [xml appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"];
    [self eol];
    configured = YES;
}

- (NSString *)description {
    return xml;    
}

@end
