//
// nod - Copyright 2012 Three Rings Design

typedef enum {
    BehaviorRunning = 1,
    BehaviorSuccess,
    BehaviorFail
} BehaviorStatus;

@interface GMTask : NSObject {
@protected
    NSString* _name;
    BehaviorStatus _lastStatus;
}

- (id)init;
- (id)initWithName:(NSString*)name;

/// Updates the task.
- (BehaviorStatus)updateTree:(float)dt;

/// Causes the task to deactivate. This is only necessary to call if the task is deactivating
/// prematurely (tasks will be automatically deactivated when they return a non-"RUNNING"
/// status value from update).
- (void)deactivate;

- (NSString*)printTreeState;

@end
