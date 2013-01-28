/*
 * Created by Simon Toens on 07/04/11.
 * Copyright 2011 shrtlist.com. All rights reserved.
 */

#import <Foundation/Foundation.h>

// http://google-collections.googlecode.com/svn/trunk/javadoc/com/google/common/collect/BiMap.html

@interface BiDictionary : NSObject {
    NSMutableDictionary *keysToValues;
    NSMutableDictionary *valuesToKeys;
    BiDictionary *inverse;
}

- (BiDictionary *)inverse;
- (void)setObject:(id)value forKey:(id)key;
- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;
- (id)objectForKey:(id)key;
- (BOOL)containsKey:(id)key;
- (NSUInteger) count;

@end
