//
// nod - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTask+Protected.h"

@interface GMStatefulTask (protected)

/// Subclasses can override this function reset any state associated with the task
- (void)reset;

@end