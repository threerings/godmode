//
// nod - Copyright 2012 Three Rings Design

#import "SemaphoreGuardDecorator.h"
#import "StatefulBehaviorTask+Protected.h"
#import "BehaviorSemaphore.h"

@implementation SemaphoreGuardDecorator

- (id)initWithName:(NSString*)name semaphore:(BehaviorSemaphore*)semaphore task:(BehaviorTask*)task {
    if ((self = [super initWithName:name])) {
        _semaphore = semaphore;
        _task = task;
    }
    return self;
}

- (void)reset {
    if (_semaphoreAcquired) {
        [_semaphore relinquish];
        _semaphoreAcquired = NO;
    }
    [_task deactivate];
}

- (BehaviorStatus)update:(float)dt {
    if (!_semaphoreAcquired) {
        _semaphoreAcquired = [_semaphore acquire];
        if (!_semaphoreAcquired) {
            return BehaviorFail;
        }
    }

    return [_task updateTree:dt];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@:%@", [super description], _semaphore.name];
}

- (id<NSFastEnumeration>)children {
    return [OOOCollections singleton:_task];
}

@end
