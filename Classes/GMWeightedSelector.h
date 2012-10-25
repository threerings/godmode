//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

@class GMRandoms;
@protocol GMRng;

@interface GMWeightedTask : NSObject
+ (GMWeightedTask*)withTask:(GMTask*)task weight:(float)weight;
@end

@interface GMWeightedSelector : GMStatefulTask <GMTaskContainer> {
@protected
    GMRandoms* _rands;
    NSArray* _children;
    GMWeightedTask* _curChild;
}

- (id)initWithName:(NSString*)name rng:(id<GMRng>)rng children:(NSArray*)children;

@end
