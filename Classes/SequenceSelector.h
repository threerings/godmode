//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

/// Executes child tasks in sequence. Succeeds when all children have succeeded. Fails when
/// any child fails.
@interface SequenceSelector : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    NSArray* _children;
    BehaviorTask* _curChild;
    int _childIdx;
}

- (id)initWithName:(NSString*)name children:(NSArray*)children;
- (id)initWithChildren:(NSArray*)children;

@end
