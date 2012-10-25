//
// godmode - Copyright 2012 Three Rings Design

#import "GMWeightedSelector.h"

#import "GMStatefulTask+Protected.h"
#import "GMRandoms.h"

@interface GMWeightedTask () {
@public
    GMTask* task;
    float weight;
    BOOL skip;
    BOOL hasRun;
}
@end

@implementation GMWeightedTask
+ (GMWeightedTask*)withTask:(GMTask*)task weight:(float)weight {
    GMWeightedTask* wt = [[GMWeightedTask alloc] init];
    wt->task = task;
    wt->weight = weight;
    return wt;
}
@end

@implementation GMWeightedSelector

- (id)initWithName:(NSString*)name rng:(id<GMRng>)rng children:(NSArray*)children {
    if ((self = [super initWithName:name])) {
        _rands = [GMRandoms withRng:rng];
        _children = children;
    }
    return self;
}

- (void)reset {
    if (_curChild != nil) {
        [_curChild->task deactivate];
        _curChild = nil;
    }
}

- (GMWeightedTask*)chooseNextChild {
    GMWeightedTask* pick = nil;
    float total = 0;
    for (GMWeightedTask* child in _children) {
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
    for (GMWeightedTask* child in _children) {
        child->skip = NO;
    }
}

- (GMStatus)update:(float)dt {
    // Are we already running a task?
    if (_curChild != nil) {
        GMStatus status = [_curChild->task updateTree:dt];

        // The task completed
        if (status != GM_Running) {
            _curChild = nil;
        }

        // Exit immediately, unless our task failed, in which case
        // we'll try to select another task, below
        if (status != GM_Fail) {
            return status;
        }
    }

    NSAssert(_curChild == nil, @"");

    int numTriedTasks = 0;
    while (numTriedTasks < _children.count) {
        GMWeightedTask* child = [self chooseNextChild];

        numTriedTasks++;
        // Skip this task on our next call to chooseNextChild()
        child->skip = true;

        GMStatus status = [child->task updateTree:dt];
        if (status == GM_Running) {
            _curChild = child;
        }

        // Exit immediately, unless our task failed, in which case we'll
        // try to select another one
        if (status != GM_Fail) {
            [self resetSkippedStatus];
            return status;
        }
    }

    [self resetSkippedStatus];

    // All of our tasks failed.
    return GM_Fail;
}

- (id<NSFastEnumeration>)children {
    NSMutableArray* tasks = [[NSMutableArray alloc] initWithCapacity:_children.count];
    for (GMWeightedTask* wt in _children) {
        [tasks addObject:wt->task];
    }
    return tasks;
}

@end
