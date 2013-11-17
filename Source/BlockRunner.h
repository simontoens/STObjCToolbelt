// @author Simon Toens on 07/04/11

#import <Foundation/Foundation.h>

@interface BlockRunner : NSObject

- (instancetype)init __unavailable;
- (instancetype)initWithIdentifier:(NSString *)identifier;

- (BlockRunner *)newBlockRunnerAsyncAfterNumberOfBlocksExceeds:(NSUInteger)asyncIfNumberOfBlockExceeds;

- (void)run:(void (^)())block;

@end