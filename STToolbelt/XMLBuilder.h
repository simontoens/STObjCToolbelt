//  Created by Simon Toens on 6/16/12.

#import <Foundation/Foundation.h>

/**
 * This is a braindead xml builder.
 */
@interface XMLBuilder : NSObject

/**
 * Adds an element.
 */
- (void)addElement:(NSString *)elementName;

/**
 * Adds an element with attributes.
 */
- (void)addElement:(NSString *)elementName attributes:(NSArray *)attributes;

/**
 * Adds an element with text data and closes the element, ie <e1>text</e1>.
 */
- (void)addElement:(NSString *)elementName value:(NSString *)value;

/**
 * Adds text data to the current element.
 */
- (void)addValue:(NSString *)value;

/**
 * Closes the current element.
 */
- (void)closeElement;

/**
 * Closes all elements.
 */
- (void)closeAllElements;

/**
 * Set a mark at the current element.
 */
- (void)mark;

/**
 * Close elements until reaching a previously set mark.
 */
- (void)closeElementsUntilMark;

/**
 * The generated xml.
 */
@property (nonatomic, strong, readonly) NSMutableString *xml;

@property (nonatomic) BOOL prettyPrint;

@end