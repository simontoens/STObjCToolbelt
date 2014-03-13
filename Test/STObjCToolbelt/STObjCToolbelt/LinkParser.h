//
//  LinkParser.h
//  STObjCToolbelt
//
//  Created by Simon Toens on 3/13/14.
//
//

#import <Foundation/Foundation.h>

@interface LinkParser : NSObject

- (instancetype)initWithHTML:(NSString *)html;

- (NSArray *)parseLinks;

@end
