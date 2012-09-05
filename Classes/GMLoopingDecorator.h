//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

typedef enum {
    GM_BreakNever = 0,
    GM_BreakOnSuccess, // if task succeeds, return SUCCESS, else loop
    GM_BreakOnFail     // if task fails, return FAIL, else loop
} GMLoopType;

@interface GMLoopingDecorator : GMStatefulTask <GMTaskContainer> {
@protected
    GMLoopType _type;
    int _targetLoopCount;
    int _curLoopCount;
    GMTask* _task;
}

- (id)initWithName:(NSString*)name type:(GMLoopType)type loopCount:(int)loopCount task:(GMTask*)task;

@end
