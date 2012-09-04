//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTask+Protected.h"

@interface StatefulBehaviorTask (protected)

/// Subclasses can override this function reset any state associated with the task
- (void)reset;

@end