// @author Simon Toens on 07/04/11

#import "BlockRunner.h"
#import "Preconditions.h"

@interface BlockRunner() {
    dispatch_queue_t queue;
    int numBlocksExecuted;
    int maxSyncBlocks;
}
@end

@implementation BlockRunner

- (instancetype)initWithIdentifier:(NSString *)identifier {
    [Preconditions assertNotNil:identifier];
    NSString *queueName = [NSString stringWithFormat:@"com.%@.BlockRunnerQueue", identifier];
    dispatch_queue_t q = dispatch_queue_create([queueName cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_SERIAL);
    return [self initWithQueue:q asyncIfNumberOfBlocksExceeds:0];
}

- (instancetype)initWithQueue:(dispatch_queue_t)aQueue asyncIfNumberOfBlocksExceeds:(NSUInteger)aMaxSyncBlocks {
    if (self = [super init]) {
        queue = aQueue;
        maxSyncBlocks = aMaxSyncBlocks;
        numBlocksExecuted = 0;
    }
    return self;
}


- (BlockRunner *)newDeferredAsyncBlockRunner:(NSUInteger)asyncIfNumberOfBlockExceeds {
    return [self initWithQueue:queue asyncIfNumberOfBlocksExceeds:asyncIfNumberOfBlockExceeds];
}

- (void)run:(void (^)())block {
    if (numBlocksExecuted >= maxSyncBlocks) {
        dispatch_async(queue, block);
    } else {
        block();
    }
    numBlocksExecuted += 1;
}

@end