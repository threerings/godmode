//
// godmode - Copyright 2012 Three Rings Design

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

- (GMStatus)update:(float)dt {
    if (!_pred.evaluate) {
        return GM_Fail;
    }
    return [_task updateTree:dt];
}

- (id<NSFastEnumeration>)children {
    return [NSArray arrayWithObjects:_pred, _task, nil];
}

@end
