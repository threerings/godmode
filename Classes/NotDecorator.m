//
// nod - Copyright 2012 Three Rings Design

#import "NotDecorator.h"
#import "StatefulBehaviorTask+Protected.h"

@implementation NotDecorator

- (id)initWithName:(NSString*)name task:(BehaviorTask*)task {
    if ((self = [super initWithName:name])) {
        _task = task;
    }
    return self;
}

- (id)initWithTask:(BehaviorTask*)task {
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
