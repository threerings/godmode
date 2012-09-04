//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

/// A selector that tries to run each of its children, every update, until it finds one
/// that succeeds.
///
/// Since children are always run in priority-order, a higher-priority task can interrupt
/// a lower-priority one that began running on a previous update.
@interface PrioritySelector : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    NSArray* _children;
    BehaviorTask* _runningTask;
}

- (id)initWithName:(NSString*)name children:(NSArray*)children;
- (id)initWithChildren:(NSArray*)children;

@end
