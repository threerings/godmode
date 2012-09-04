//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"

@protocol IFloatValue;

/// A task that completes after a specified amount of time
@interface TimerAction : StatefulBehaviorTask {
@protected
    float _totalTime;
    float _elapsedTime;
}

- (id)initWithName:(NSString*)name time:(float)time;
- (id)initWithTime:(float)time;

@end
