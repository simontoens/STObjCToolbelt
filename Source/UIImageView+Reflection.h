// @author http://developer.apple.com/library/ios/#samplecode/Reflection/Introduction/Intro.html

#import <UIKit/UIKit.h>

@interface UIImageView (Reflection)

- (UIImage *)reflectedTopImageWithHeight:(NSUInteger)height;
- (UIImage *)reflectedBottomImageWithHeight:(NSUInteger)height;

@end