//
// nod - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

@class OOORandoms;

@interface WeightedTask : NSObject
+ (WeightedTask*)withTask:(GMTask*)task weight:(float)weight;
@end

@interface GMWeightedSelector : GMStatefulTask <GMTaskContainer> {
@protected
    OOORandoms* _rands;
    NSArray* _children;
    WeightedTask* _curChild;
}

- (id)initWithName:(NSString*)name rands:(OOORandoms*)rands children:(NSArray*)children;
- (id)initWithRands:(OOORandoms*)rands children:(NSArray*)children;

@end
