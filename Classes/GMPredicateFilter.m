//
// nod - Copyright 2012 Three Rings Design

#import "GMPredicateFilter.h"
#import "GMPredicate.h"
#import "GMStatefulTask+Protected.h"

@implementation GMPredicateFilter

- (id)initWithName:(NSString*)name pred:(GMPredicate*)pred task:(GMTask*)task {
    if ((self = [super initWithName:name])) {
        _pred = pred;
        _task = task;
    }
    return self;
}

- (void)reset {
    [_task deactivate];
}

- (BehaviorStatus)update:(float)dt {
    if (!_pred.evaluate) {
        return BehaviorFail;
    }
    return [_task updateTree:dt];
}

- (id<NSFastEnumeration>)children {
    return [NSArray arrayWithObjects:_pred, _task, nil];
}

@end
