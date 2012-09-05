//
// godmode - Copyright 2012 Three Rings Design

typedef enum {
    GM_Running = 1,
    GM_Success,
    GM_Fail
} GMStatus;

@interface GMTask : NSObject {
@protected
    NSString* _name;
    GMStatus _lastStatus;
}

- (id)init;
- (id)initWithName:(NSString*)name;

/// Updates the task.
- (GMStatus)updateTree:(float)dt;

/// Causes the task to deactivate. This is only necessary to call if the task is deactivating
/// prematurely (tasks will be automatically deactivated when they return a non-"RUNNING"
/// status value from update).
- (void)deactivate;

- (NSString*)printTreeState;

@end
