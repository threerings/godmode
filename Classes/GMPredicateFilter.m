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
    // call [pred updateTree] so that the predicate's _lastStatus gets set
    if ([_pred updateTree:dt] != GM_Success) {
        return GM_Fail;
    }
    return [_task updateTree:dt];
}

- (id<NSFastEnumeration>)children {
    return @[_pred, _task];
}

@end
