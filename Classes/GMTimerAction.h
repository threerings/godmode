//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"

/// A task that completes after a specified amount of time
@interface GMTimerAction : GMStatefulTask {
@protected
    float _totalTime;
    float _elapsedTime;
}

- (id)initWithName:(NSString*)name time:(float)time;

@end
