//
// nod - Copyright 2012 Three Rings Design

#import "GMStatefulTask+Protected.h"

@implementation GMStatefulTask

- (id)initWithName:(NSString*)name {
    return [super initWithName:name];
}

- (id)init {
    return [self initWithName:nil];
}

- (BehaviorStatus)updateTree:(float)dt {
    _lastStatus = [self update:dt];
    _running = (_lastStatus == BehaviorRunning);
    if (!_running) {
        [self reset];
    }
    return _lastStatus;
}

- (void)deactivate {
    if (_running) {
        _running = NO;
        [self reset];
    }
}

- (void)reset {}

@end
