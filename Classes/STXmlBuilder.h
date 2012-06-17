//  Created by Simon Toens on 6/16/12.

#import <Foundation/Foundation.h>

/**
 * This is a braindead xml builder.
 */
@interface STXmlBuilder : NSObject

/**
 * Add an element.
 */
- (STXmlBuilder *)addElement:(NSString *)elementName;

/**
 * Add an element with attributes.
 */
- (STXmlBuilder *)addElement:(NSString *)elementName attributes:(NSDictionary *)attributes;

/**
 * Closes the current element.
 */
- (STXmlBuilder *)closeElement;

/**
 * Closes all elements.
 */
- (STXmlBuilder *)closeAllElements;

/**
 * The generated xml.
 */
@property (nonatomic, strong, readonly) NSMutableString *xml;

@end