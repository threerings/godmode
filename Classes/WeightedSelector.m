//
// nod - Copyright 2012 Three Rings Design

#import "WeightedSelector.h"
#import "StatefulBehaviorTask+Protected.h"

@interface WeightedTask () {
@public
    BehaviorTask* task;
    float weight;
    BOOL skip;
    BOOL hasRun;
}
@end

@implementation WeightedTask
+ (WeightedTask*)withTask:(BehaviorTask*)task weight:(float)weight {
    WeightedTask* wt = [[WeightedTask alloc] init];
    wt->task = task;
    wt->weight = weight;
    return wt;
}
@end

@implementation WeightedSelector

- (id)initWithName:(NSString*)name rands:(OOORandoms*)rands children:(NSArray*)children {
    if ((self = [super initWithName:name])) {
        _rands = rands;
        _children = children;
    }
    return self;
}

- (id)initWithRands:(OOORandoms*)rands children:(NSArray*)children {
    return [self initWithName:nil rands:rands children:children];
}

- (void)reset {
    if (_curChild != nil) {
        [_curChild->task deactivate];
        _curChild = nil;
    }
}

- (WeightedTask*)chooseNextChild {
    WeightedTask* pick = nil;
    float total = 0;
    for (WeightedTask* child in _children) {
        if (!child->skip) {
            total += child->weight;
            if (pick == nil || [_rands getFloat:total] < child->weight) {
                pick = child;
            }
        }
    }
    return pick;
}

- (void)resetSkippedStatus {
    for (WeightedTask* child in _children) {
        child->skip = NO;
    }
}

- (BehaviorStatus)update:(float)dt {
    // Are we already running a task?
    if (_curChild != nil) {
        BehaviorStatus status = [_curChild->task updateTree:dt];

        // The task completed
        if (status != BehaviorRunning) {
            _curChild = nil;
        }

        // Exit immediately, unless our task failed, in which case
        // we'll try to select another task, below
        if (status != BehaviorFail) {
            return status;
        }
    }

    NSAssert(_curChild == nil, @"");

    int numTriedTasks = 0;
    while (numTriedTasks < _children.count) {
        WeightedTask* child = [self chooseNextChild];

        numTriedTasks++;
        // Skip this task on our next call to chooseNextChild()
        child->skip = true;

        BehaviorStatus status = [child->task updateTree:dt];
        if (status == BehaviorRunning) {
            _curChild = child;
        }

        // Exit immediately, unless our task failed, in which case we'll
        // try to select another one
        if (status != BehaviorFail) {
            [self resetSkippedStatus];
            return status;
        }
    }

    [self resetSkippedStatus];

    // All of our tasks failed.
    return BehaviorFail;
}

- (id<NSFastEnumeration>)children {
    return [OOOCollections map:_children transformer:^BehaviorTask* (WeightedTask* wt) {
        return wt->task;
    }];
}

@end
