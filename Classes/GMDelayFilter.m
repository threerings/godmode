//
// nod - Copyright 2012 Three Rings Design

#import "GMDelayFilter.h"
#import "GMStatefulTask+Protected.h"

@implementation GMDelayFilter

- (id)initWithName:(NSString*)name
          minDelay:(OOOFloatRange*)minDelay
      timeCallback:(DelayFilterTimeCallback)curTime
              task:(GMTask*)task {

    if ((self = [super initWithName:name])) {
        _curTime = [curTime copy];
        _minDelay = minDelay;
        _task = task;
        _lastCompletionTime = -FLT_MAX;
    }
    return self;
}

- (float)timeNow {
    return _curTime();
}

- (void)reset {
    if (_taskRunning) {
        [_task deactivate];
        _taskRunning = NO;
        _inited = NO;
    }
}

- (BehaviorStatus)update:(float)dt {
    if (!_inited) {
        _curDelay = _minDelay.next;
        _inited = YES;
    }

    float now = self.timeNow;

    if (!_taskRunning && ((now - _lastCompletionTime) < _curDelay)) {
        // can't run
        return BehaviorFail;
    }

    BehaviorStatus status = [_task updateTree:dt];
    _taskRunning = (status == BehaviorRunning);
    if (!_taskRunning) {
        _inited = NO;
    }
    if (status == BehaviorSuccess) {
        _lastCompletionTime = now;
    }
    return status;
}

- (id<NSFastEnumeration>)children {
    return [OOOCollections singleton:_task];
}

@end
