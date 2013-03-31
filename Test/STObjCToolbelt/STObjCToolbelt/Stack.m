// @author Simon Toens 10/03/10

#import "Preconditions.h"
#import "Stack.h"

@interface Stack() {
    @private
    NSMutableArray *elements;
}
@end

@implementation Stack

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

- (id)peak {
    if ([elements count] == 0) {
        return nil;
    }
    return [elements lastObject];
}

- (BOOL)empty {
    return [elements count] == 0;
}

- (NSUInteger)count {
    return [elements count];	
}

- (NSString *)description {
    return [elements description];
}

@end