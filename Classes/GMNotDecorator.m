//
// godmode - Copyright 2012 Three Rings Design

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

- (GMStatus)update:(float)dt {
    GMStatus status = [_task updateTree:dt];
    switch (status) {
    case GM_Success: return GM_Fail;
    case GM_Fail: return GM_Success;
    case GM_Running: return GM_Running;
    }
}

- (id<NSFastEnumeration>)children {
    return @[_task];
}

@end
