//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

typedef float (^DelayFilterTimeCallback)();

@interface GMDelayFilter : GMStatefulTask <GMTaskContainer> {
@protected
    GMTask* _task;

    DelayFilterTimeCallback _curTime;
    OOOFloatRange* _minDelay;

    BOOL _inited;
    float _curDelay;
    BOOL _taskRunning;
    float _lastCompletionTime;
}

- (id)initWithName:(NSString*)name
          minDelay:(OOOFloatRange*)minDelay
      timeCallback:(DelayFilterTimeCallback)curTime
              task:(GMTask*)task;

@end
