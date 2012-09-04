//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

@class OOORandoms;

@interface WeightedTask : NSObject
+ (WeightedTask*)withTask:(BehaviorTask*)task weight:(float)weight;
@end

@interface WeightedSelector : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    OOORandoms* _rands;
    NSArray* _children;
    WeightedTask* _curChild;
}

- (id)initWithName:(NSString*)name rands:(OOORandoms*)rands children:(NSArray*)children;
- (id)initWithRands:(OOORandoms*)rands children:(NSArray*)children;

@end
