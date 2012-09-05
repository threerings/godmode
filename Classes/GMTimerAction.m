//
// godmode - Copyright 2012 Three Rings Design

#import "GMTimerAction.h"
#import "GMStatefulTask+Protected.h"

@implementation GMTimerAction

- (id)initWithName:(NSString*)name time:(float)time {
    if ((self = [super initWithName:name])) {
        _totalTime = time;
    }
    return self;
}

- (id)initWithTime:(float)time {
    return [self initWithName:nil time:time];
}

- (void)reset {
    _elapsedTime = 0;
}

- (GMStatus)update:(float)dt {
    _elapsedTime += dt;
    return (_elapsedTime >= _totalTime ? GM_Success : GM_Running);
}

@end
