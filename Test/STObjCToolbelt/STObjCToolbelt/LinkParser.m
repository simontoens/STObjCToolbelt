//
//  LinkParser.m
//  STObjCToolbelt
//
//  Created by Simon Toens on 3/13/14.
//
//

#import "LinkParser.h"

@implementation LinkParser {
    NSString *_html;
}

- (instancetype)initWithHTML:(NSString *)html {
    if (self = [super init]) {
        _html = html;
    }
    return self;
}

- (NSArray *)parseLinks {
    for (int i = 1; i < [_html length]; i++) {
        
    }
    return nil;
}


@end
