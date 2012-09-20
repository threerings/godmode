//
// godmode - Copyright 2012 Three Rings Design

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

- (GMStatus)update:(float)dt {
    if (!_inited) {
        _curDelay = _minDelay.next;
        _inited = YES;
    }

    float now = self.timeNow;

    if (!_taskRunning && ((now - _lastCompletionTime) < _curDelay)) {
        // can't run
        return GM_Fail;
    }

    GMStatus status = [_task updateTree:dt];
    _taskRunning = (status == GM_Running);
    if (!_taskRunning) {
        _inited = NO;
    }
    if (status == GM_Success) {
        _lastCompletionTime = now;
    }
    return status;
}

- (id<NSFastEnumeration>)children {
    return @[_task];
}

@end
