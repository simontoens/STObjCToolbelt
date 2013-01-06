// Created by Simon Toens on 10/23/11.

#import <Foundation/Foundation.h>

/**
 * A one-to-many dictionary.
 *
 * http://en.wikipedia.org/wiki/Multimap
 */
@interface MultiDictionary : NSObject 

/**
 * Add a mapping.
 */
- (void)setObject:(id)anObject forKey:(id)aKey;

/**
 * Returns a read only view of all values mapped to the specified key.
 */
- (NSSet *)objectsForKey:(id)aKey;

/**
 * Removes the specified key and all values it maps to.
 */
- (void)removeObjectsForKey:(id)aKey;

/**
 * Removes the specified value, does not remove any corresponding keys.
 */
- (void)removeValue:(id)aValue;

/**
 * Removes all mappings.
 */
- (void)removeAllObjects;

/**
 * Returns a read only view of all mapped keys.
 */
- (NSArray *)allKeys;

/**
 * Returns a read only view of all mapped values.
 */
- (NSArray *)allValues;

/**
 * Returns YES if the specified key exists, NO otherwise.
 */
- (BOOL)containsKey:(id)key;

/**
 * Returns the number of mapped keys.
 */
- (NSUInteger)count;

@end
