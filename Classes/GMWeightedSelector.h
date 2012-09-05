//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

@class OOORandoms;

@interface GMWeightedTask : NSObject
+ (GMWeightedTask*)withTask:(GMTask*)task weight:(float)weight;
@end

@interface GMWeightedSelector : GMStatefulTask <GMTaskContainer> {
@protected
    OOORandoms* _rands;
    NSArray* _children;
    GMWeightedTask* _curChild;
}

- (id)initWithName:(NSString*)name rands:(OOORandoms*)rands children:(NSArray*)children;

@end
