//
// godmode - Copyright 2012 Three Rings Design

#import "GMSemaphoreGuardDecorator.h"
#import "GMStatefulTask+Protected.h"
#import "GMSemaphore.h"

@implementation GMSemaphoreGuardDecorator

- (id)initWithName:(NSString*)name semaphore:(GMSemaphore*)semaphore task:(GMTask*)task {
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

- (GMStatus)update:(float)dt {
    if (!_semaphoreAcquired) {
        _semaphoreAcquired = [_semaphore acquire];
        if (!_semaphoreAcquired) {
            return GM_Fail;
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
