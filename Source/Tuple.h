/*
 * Created by Simon Toens on 06/25/11.
 * Copyright 2011 shrtlist.com. All rights reserved.
 */

@interface Tuple : NSObject {
}

@property (nonatomic, strong) id t1;
@property (nonatomic, strong) id t2;

- (id) init:(id)at1 t2:(id)at2;

+ (Tuple *)getTuple:(id)t1 t2:(id)t2;

@end