//
// nod - Copyright 2012 Three Rings Design

#import "GMNotDecorator.h"
#import "GMStatefulTask+Protected.h"

@implementation GMNotDecorator

- (id)initWithName:(NSString*)name task:(GMTask*)task {
    if ((self = [super initWithName:name])) {
        _task = task;
    }
    return self;
}

- (id)initWithTask:(GMTask*)task {
    return [self initWithName:nil task:task];
}

- (void)reset {
    [_task deactivate];
}

- (BehaviorStatus)update:(float)dt {
    BehaviorStatus status = [_task updateTree:dt];
    switch (status) {
    case BehaviorSuccess: return BehaviorFail;
    case BehaviorFail: return BehaviorSuccess;
    case BehaviorRunning: return BehaviorRunning;
    }
}

- (id<NSFastEnumeration>)children {
    return [OOOCollections singleton:_task];
}

@end
