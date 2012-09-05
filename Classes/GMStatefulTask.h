//
// godmode - Copyright 2012 Three Rings Design

#import "GMTask.h"

/// The base class for BehaviorTasks with state.
/// StatefulBehaviorTasks can have activation and deactivation logic.
/// (See GMStatefulTask+Protected)

@interface GMStatefulTask : GMTask {
@private
    BOOL _running;
}

- (id)initWithName:(NSString*)name;
- (id)init;

@end
