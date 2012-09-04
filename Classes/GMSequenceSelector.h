//
// nod - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

/// Executes child tasks in sequence. Succeeds when all children have succeeded. Fails when
/// any child fails.
@interface GMSequenceSelector : GMStatefulTask <GMTaskContainer> {
@protected
    NSArray* _children;
    GMTask* _curChild;
    int _childIdx;
}

- (id)initWithName:(NSString*)name children:(NSArray*)children;
- (id)initWithChildren:(NSArray*)children;

@end
