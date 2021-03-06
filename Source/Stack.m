// @author Simon Toens 10/03/10

#import "Preconditions.h"
#import "Stack.h"

@interface Stack() {
    @private
    NSMutableArray *elements;
}
@end

@implementation Stack

#pragma mark - Stack

- (id)init {
    if (self = [super init]) {
	    elements = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)push:(id)thing {
    [elements addObject:thing];
}

- (id)pop {
	if ([elements count] == 0) {
        return nil;
	}
	id rtn = [elements lastObject];
	[elements removeLastObject];
	return rtn;
}

- (id)peek {
    if ([elements count] == 0) {
        return nil;
    }
    return [elements lastObject];
}

- (NSArray *)allObjects {
    return elements;
}

#pragma mark - Properties

- (BOOL)empty {
    return [elements count] == 0;
}

- (NSUInteger)count {
    return [elements count];	
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[Stack class]]) {
        return NO;
    }
    return [elements isEqual:((Stack *)object)->elements];
}

- (NSUInteger)hash {
    return [elements hash];
}

- (NSString *)description {
    return [elements description];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Stack *copy = [[Stack alloc] init];
    copy->elements = [[NSMutableArray alloc] initWithArray:elements copyItems:YES];
    return copy;
}

@end