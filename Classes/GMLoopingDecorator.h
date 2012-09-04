//
// nod - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

typedef enum {
    LoopBreakNone,
    LoopBreakOnSuccess, // if task succeeds, return SUCCESS, else loop
    LoopBreakOnFail     // if task fails, return FAIL, else loop
} LoopBreakCondition;

@interface GMLoopingDecorator : GMStatefulTask <GMTaskContainer> {
@protected
    LoopBreakCondition _breakCondition;
    int _targetLoopCount;
    int _curLoopCount;
    GMTask* _task;
}

- (id)initWithName:(NSString*)name breakCondition:(LoopBreakCondition)exitCondition
         loopCount:(int)loopCount task:(GMTask*)task;

@end
