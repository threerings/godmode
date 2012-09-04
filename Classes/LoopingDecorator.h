//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

typedef enum {
    LoopBreakNone,
    LoopBreakOnSuccess, // if task succeeds, return SUCCESS, else loop
    LoopBreakOnFail     // if task fails, return FAIL, else loop
} LoopBreakCondition;

@interface LoopingDecorator : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    LoopBreakCondition _breakCondition;
    int _targetLoopCount;
    int _curLoopCount;
    BehaviorTask* _task;
}

- (id)initWithName:(NSString*)name breakCondition:(LoopBreakCondition)exitCondition
         loopCount:(int)loopCount task:(BehaviorTask*)task;

@end
