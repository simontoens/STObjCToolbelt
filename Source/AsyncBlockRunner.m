// @author Simon Toens on 07/04/11

#import "AsyncBlockRunner.h"

@interface AsyncBlockRunner() {
    dispatch_queue_t queue;
}
@end

@implementation AsyncBlockRunner

- (instancetype)init {
    if (self = [super init]) {
        queue = dispatch_queue_create("com.example.MyQueue", NULL);
    }
    return self;
}

- (void)run:(void (^)())work {
    dispatch_async(queue, work);
}

- (void)runJobs:(NSArray *)jobs {
    for (void(^work)() in jobs) {
        dispatch_async(queue, work);
    }
}

- (void)runJobsAndWait:(NSArray *)jobs {
    for (void(^work)() in jobs) {
        dispatch_sync(queue, work);
    }
}

@end