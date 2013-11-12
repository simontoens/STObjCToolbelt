// @author Simon Toens on 07/04/11

#import <Foundation/Foundation.h>

@interface AsyncBlockRunner : NSObject

- (void)run:(void (^)())work;
- (void)runJobs:(NSArray *)jobs;
- (void)runJobsAndWait:(NSArray *)jobs;

@end