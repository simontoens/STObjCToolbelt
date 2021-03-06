// @author Simon Toens 6/16/12

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
@property (nonatomic, strong, readonly) NSString *xml;

/**
 * Whether to pretty-print the generated xml.  Defaults to NO.
 */
@property (nonatomic) BOOL prettyPrint;

/**
 * Whether to include the initial <?xml ... processing instruction.  Defaults to YES.
 */
@property (nonatomic) BOOL includeXmlProcessingInstruction;

@end