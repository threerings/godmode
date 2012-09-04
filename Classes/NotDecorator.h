//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

/// A decorator that inverts the Status of its decorated task. That is:
/// Status.SUCCESS -> Status.FAIL
/// Status.FAIL -> Status.SUCCESS
/// Status.RUNNING -> Status.RUNNING
@interface NotDecorator : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    BehaviorTask* _task;
}

- (id)initWithName:(NSString*)name task:(BehaviorTask*)task;
- (id)initWithTask:(BehaviorTask*)task;

@end
