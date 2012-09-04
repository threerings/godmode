//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

typedef float (^DelayFilterTimeCallback)();

@interface DelayFilter : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    BehaviorTask* _task;

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
              task:(BehaviorTask*)task;

@end
