//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

@class GMFloatRange;

typedef float (^DelayFilterTimeCallback)();

@interface GMDelayFilter : GMStatefulTask <GMTaskContainer> {
@protected
    GMTask* _task;

    DelayFilterTimeCallback _curTime;
    GMFloatRange* _minDelay;

    BOOL _inited;
    float _curDelay;
    BOOL _taskRunning;
    float _lastCompletionTime;
}

- (id)initWithName:(NSString*)name
          minDelay:(GMFloatRange*)minDelay
      timeCallback:(DelayFilterTimeCallback)curTime
              task:(GMTask*)task;

@end
