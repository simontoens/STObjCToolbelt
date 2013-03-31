//
//  Stack.h
//  Maze
//
//  Created by Simon Toens on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Stack : NSObject {

    NSMutableArray *elements;

}

- (bool)isEmpty;
- (int)count;
- (id)pop;
- (void)push:(id) element;
- (void)pushAll:(id)someElements;

@end
