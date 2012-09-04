//
// nod - Copyright 2012 Three Rings Design

#import "GMFlagDecorator.h"
#import "GMStatefulTask+Protected.h"

@implementation GMFlagDecorator

- (id)initWithName:(NSString*)name flags:(OOOMutableFlags*)flags flag:(int)flag task:(GMTask*)task {
    if ((self = [super initWithName:name])) {
        _flags = flags;
        _flag = flag;
        _task = task;
    }
    return self;
}

- (void)reset {
    [_task deactivate];
    [_flags clearFlag:_flag];
}

- (BehaviorStatus)update:(float)dt {
    [_flags setFlag:_flag];
    return [_task updateTree:dt];
}

- (id<NSFastEnumeration>)children {
    return [OOOCollections singleton:_task];
}

@end
