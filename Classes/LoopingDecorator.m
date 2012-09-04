//
// nod - Copyright 2012 Three Rings Design

#import "LoopingDecorator.h"
#import "StatefulBehaviorTask+Protected.h"

static NSString* GetBreakConditionString (LoopBreakCondition until) {
    switch (until) {
        ENUM_STRING(LoopBreakNone);
        ENUM_STRING(LoopBreakOnSuccess);
        ENUM_STRING(LoopBreakOnFail);
    }
}

@implementation LoopingDecorator

- (id)initWithName:(NSString*)name breakCondition:(LoopBreakCondition)breakCondition
         loopCount:(int)loopCount task:(BehaviorTask*)task {
    if ((self = [super initWithName:name])) {
        _breakCondition = breakCondition;
        _targetLoopCount = loopCount;
        _task = task;
    }
    return self;
}

- (void)reset {
    _curLoopCount = 0;
    [_task deactivate];
}

- (BehaviorStatus)update:(float)dt {
    BehaviorStatus status = [_task updateTree:dt];
    if (status == BehaviorRunning) {
        return BehaviorRunning;
    }

    if ((_breakCondition == LoopBreakOnSuccess && status == BehaviorSuccess) ||
        (_breakCondition == LoopBreakOnFail && status == BehaviorFail)) {
        // break condition met
        return status;
    } else if (_targetLoopCount > 0 && ++_curLoopCount >= _targetLoopCount) {
        // hit the loop count
        return BehaviorSuccess;
    } else {
        return BehaviorRunning;
    }
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ %@", [super description], GetBreakConditionString(_breakCondition)];
}

- (id<NSFastEnumeration>)children {
    return [OOOCollections singleton:_task];
}

@end
