//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorTask.h"

/// The base class for BehaviorTasks with state.
/// StatefulBehaviorTasks can have activation and deactivation logic.
/// (See StatefulBehaviorTask+Protected.h)

@interface StatefulBehaviorTask : BehaviorTask {
@private
    BOOL _running;
}

- (id)initWithName:(NSString*)name;
- (id)init;

@end
