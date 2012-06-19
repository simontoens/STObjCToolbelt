//  Created by Simon Toens on 6/16/12.

#import <Foundation/Foundation.h>

/**
 * This is a braindead xml builder.
 */
@interface STXmlBuilder : NSObject

/**
 * Adds an element.
 */
- (void)addElement:(NSString *)elementName;

/**
 * Adds an element with attributes.
 */
- (void)addElement:(NSString *)elementName attributes:(NSArray *)attributes;

/**
 * Adds text data as an element child value: <e1>text</e1>.
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
 * The generated xml.
 */
@property (nonatomic, strong, readonly) NSMutableString *xml;

@property (nonatomic) BOOL prettyPrint;

@end