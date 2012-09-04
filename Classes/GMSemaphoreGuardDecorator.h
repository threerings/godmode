//
// nod - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

@class GMSemaphore;

@interface GMSemaphoreGuardDecorator : GMStatefulTask <GMTaskContainer> {
@protected
    GMSemaphore* _semaphore;
    GMTask* _task;
    BOOL _semaphoreAcquired;
}

- (id)initWithName:(NSString*)name semaphore:(GMSemaphore*)semaphore task:(GMTask*)task;

@end
