// @author Simon Toens 6/16/12.

#import "XMLBuilder.h"

@interface XMLBuilder()
@property (nonatomic, assign) BOOL configured;
@property (nonatomic, strong) NSMutableArray *elementStack;
@property (nonatomic, strong) NSMutableArray *markStack;
@property (nonatomic, strong, readwrite) NSMutableString *xmlDocument;
@end

@implementation XMLBuilder

# pragma mark - Public methods

- (id)init {
    if (self = [super init]) {
        self.elementStack = [[NSMutableArray alloc] init];
        self.includeXmlProcessingInstruction = YES;
        self.markStack = [[NSMutableArray alloc] init];
        self.prettyPrint = NO;
        self.xmlDocument = [[NSMutableString alloc] init];
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
    [self.xmlDocument appendString:value];
    [self eol];
}

- (void)closeElement {
    NSString *elementName = [self.elementStack lastObject];
    [self.elementStack removeLastObject];
    [self indent];
    [self.xmlDocument appendFormat:@"</%@>", elementName];
    [self eol];
}

- (void)closeAllElements {
    while ([self.elementStack count] > 0) {
        [self closeElement];
    }
}

- (void)mark {
    [self.markStack addObject:[NSNumber numberWithUnsignedLong:[self.elementStack count]]];
}

- (void)closeElementsUntilMark {
    NSUInteger elementCount = [self.elementStack count];
    NSUInteger mark = [[self.markStack lastObject] unsignedLongValue];
    [self.markStack removeLastObject];
    for (NSUInteger i = mark; i < elementCount; i++) {
        [self closeElement];    
    }
}

#pragma mark - Properties

- (NSString *)xml {
    return self.xmlDocument;
}

#pragma mark - Private methods

- (void)write:(NSString *)elementName attributes:(NSArray *)attributes {
    if (!self.configured) {
        [self configure];
    }
    [self indent];
    [self.xmlDocument appendFormat:@"<%@", elementName];
    if (attributes) {
        for (NSUInteger i = 0; i < [attributes count]; i+=2) {
            [self.xmlDocument appendString:@" "];
            [self.xmlDocument appendFormat:@"%@=\"%@\"", [attributes objectAtIndex:i], [attributes objectAtIndex:i+1]];
        }
    }
    [self.xmlDocument appendString:@">"];
    [self eol];
    [self.elementStack addObject:elementName];
}

- (void)indent {
    if (!self.prettyPrint) {
        return;
    }
    for (NSUInteger i = 0; i < [self.elementStack count]; i++) {
        [self.xmlDocument appendString:@"  "];
    }
}

- (void)eol {
    if (!self.prettyPrint) {
        return;
    }
    [self.xmlDocument appendString:@"\n"];
}

- (void)configure {
    if (self.includeXmlProcessingInstruction) {
        [self.xmlDocument appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"];
        [self eol];
    }
    self.configured = YES;
}

- (NSString *)description {
    if (!self.configured) {
        [self configure];
    }
    return self.xmlDocument;    
}

@end