//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

/// A selector that tries to run each of its children, every update, until it finds one
/// that succeeds.
///
/// Since children are always run in priority-order, a higher-priority task can interrupt
/// a lower-priority one that began running on a previous update.
@interface GMPrioritySelector : GMStatefulTask <GMTaskContainer> {
@protected
    NSArray* _children;
    GMTask* _runningTask;
}

- (id)initWithName:(NSString*)name children:(NSArray*)children;

@end
