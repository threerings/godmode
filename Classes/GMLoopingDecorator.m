//
// godmode - Copyright 2012 Three Rings Design

#import "GMLoopingDecorator.h"
#import "GMStatefulTask+Protected.h"

static NSString* GetTypeString (GMLoopType type) {
    switch (type) {
        ENUM_STRING(GM_BreakNever);
        ENUM_STRING(GM_BreakOnSuccess);
        ENUM_STRING(GM_BreakOnFail);
    }
}

@implementation GMLoopingDecorator

- (id)initWithName:(NSString*)name type:(GMLoopType)type loopCount:(int)loopCount task:(GMTask*)task {
    if ((self = [super initWithName:name])) {
        _type = type;
        _targetLoopCount = loopCount;
        _task = task;
    }
    return self;
}

- (void)reset {
    _curLoopCount = 0;
    [_task deactivate];
}

- (GMStatus)update:(float)dt {
    GMStatus status = [_task updateTree:dt];
    if (status == GM_Running) {
        return GM_Running;
    }

    if ((_type == GM_BreakOnSuccess && status == GM_Success) ||
        (_type == GM_BreakOnFail && status == GM_Fail)) {
        // break condition met
        return status;
    } else if (_targetLoopCount > 0 && ++_curLoopCount >= _targetLoopCount) {
        // hit the loop count
        return GM_Success;
    } else {
        return GM_Running;
    }
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@ %@", [super description], GetTypeString(_type)];
}

- (id<NSFastEnumeration>)children {
    return @[_task];
}

@end
