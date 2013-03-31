//
//  Stack.m
//  Maze
//
//  Created by Simon Toens on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Stack.h"


@implementation Stack

- (id)init {
    self = [super init];
	if (self) {
	    elements = [[NSMutableArray alloc] init];
	}
	return self;
}

- (bool)isEmpty {
    return [elements count] == 0;	
}

- (void)push:(id)element {
    [elements addObject:element];
}

- (void)pushAll:(id)someElements {
    for (id e in someElements) {
        [self push:e];
    }
}

- (id)pop {
	if ([elements count] == 0) {
		@throw [NSException exceptionWithName:@"EmptyStackException" reason:@"The stack is empty" userInfo:nil];
	}
	id rtn = [elements objectAtIndex:[elements count] - 1];
	[elements removeLastObject];
	return rtn;
}

- (int)count {
    return [elements count];	
}

- (NSString *)description {
    return [elements description];
}

@end