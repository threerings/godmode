//
// nod - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

/// A decorator that inverts the Status of its decorated task. That is:
/// Status.SUCCESS -> Status.FAIL
/// Status.FAIL -> Status.SUCCESS
/// Status.RUNNING -> Status.RUNNING
@interface GMNotDecorator : GMStatefulTask <GMTaskContainer> {
@protected
    GMTask* _task;
}

- (id)initWithName:(NSString*)name task:(GMTask*)task;
- (id)initWithTask:(GMTask*)task;

@end
