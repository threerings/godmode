//
// nod - Copyright 2012 Three Rings Design

#import "ParallelSelector.h"
#import "StatefulBehaviorTask+Protected.h"

static NSString* GetBreakConditionString (ParallelExitCondition until) {
    switch (until) {
        ENUM_STRING(PEC_ALL_SUCCESS);
        ENUM_STRING(PEC_ANY_SUCCESS);
        ENUM_STRING(PEC_ALL_FAIL);
        ENUM_STRING(PEC_ANY_FAIL);
        ENUM_STRING(PEC_ALL_COMPLETE);
        ENUM_STRING(PEC_ANY_COMPLETE);
    }
}

@implementation ParallelSelector

- (id)initWithName:(NSString*)name until:(ParallelExitCondition)until children:(NSArray*)children {
    if ((self = [super initWithName:name])) {
        _until = until;
        _children = children;
    }
    return self;
}

- (id)init:(ParallelExitCondition)until children:(NSArray*)children {
    return [self initWithName:nil until:until children:children];
}

- (void)reset {
    for (BehaviorTask* child in _children) {
        [child deactivate];
    }
}

- (BehaviorStatus)update:(float)dt {
    BOOL runningChildren = NO;
    for (BehaviorTask* child in _children) {
        BehaviorStatus childStatus = [child updateTree:dt];
        if (childStatus == BehaviorSuccess) {
            if (_until == PEC_ANY_SUCCESS || _until == PEC_ANY_COMPLETE) {
                return BehaviorSuccess;
            } else if (_until == PEC_ALL_FAIL) {
                return BehaviorFail;
            }

        } else if (childStatus == BehaviorFail) {
            if (_until == PEC_ANY_FAIL || _until == PEC_ANY_COMPLETE) {
                return BehaviorSuccess;
            } else if (_until == PEC_ALL_SUCCESS) {
                return BehaviorFail;
            }
        } else {
            runningChildren = YES;
        }
    }

    return (runningChildren ? BehaviorRunning : BehaviorSuccess);
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@:%@", [super description], GetBreakConditionString(_until)];
}

- (id<NSFastEnumeration>)children {
    return _children;
}

@end
