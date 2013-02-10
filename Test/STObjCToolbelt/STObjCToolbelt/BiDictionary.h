// @author Simon Toens on 07/04/11

#import <Foundation/Foundation.h>

// http://google-collections.googlecode.com/svn/trunk/javadoc/com/google/common/collect/BiMap.html

@interface BiDictionary : NSObject

- (BiDictionary *)inverse;
- (void)setObject:(id)value forKey:(id)key;
- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;
- (id)objectForKey:(id)key;
- (BOOL)containsKey:(id)key;

@property (nonatomic, readonly) NSUInteger count;

@end