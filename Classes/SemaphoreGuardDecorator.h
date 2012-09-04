//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

@class BehaviorSemaphore;

@interface SemaphoreGuardDecorator : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    BehaviorSemaphore* _semaphore;
    BehaviorTask* _task;
    BOOL _semaphoreAcquired;
}

- (id)initWithName:(NSString*)name semaphore:(BehaviorSemaphore*)semaphore task:(BehaviorTask*)task;

@end
