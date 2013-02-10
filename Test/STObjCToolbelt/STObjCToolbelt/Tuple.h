// @author Simon Toens 6/25/11

@interface Tuple : NSObject

+ (Tuple *)tupleWithValues:(id)t1 t2:(id)t2;

- (id)init:(id)at1 t2:(id)at2;

@property (nonatomic, strong, readonly) id t1;
@property (nonatomic, strong, readonly) id t2;

@end