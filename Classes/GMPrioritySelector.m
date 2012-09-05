//
// godmode - Copyright 2012 Three Rings Design

#import "GMPrioritySelector.h"
#import "GMStatefulTask+Protected.h"

@implementation GMPrioritySelector

- (id)initWithName:(NSString*)name children:(NSArray*)children {
    if ((self = [super initWithName:name])) {
        _children = children;
    }
    return self;
}

- (id)initWithChildren:(NSArray*)children {
    return [self initWithName:nil children:children];
}

- (void)reset {
    if (_runningTask != nil) {
        [_runningTask deactivate];
        _runningTask = nil;
    }
}

- (GMStatus)update:(float)dt {
    // Iterate all children till we find one that doesn't fail.
    GMStatus status = GM_Success;
    for (GMTask* task in _children) {
        status = [task updateTree:dt];

        // if the child succeeded, or is still running, we'll exit the loop
        if (status != GM_Fail) {
            // Did we interrupt a lower-priority task that was already running?
            // nb: the lower-priority task will be deactivated *after* the higher-priority
            // one is activated
            if (_runningTask != task && _runningTask != nil) {
                [_runningTask deactivate];
            }

            _runningTask = (status == GM_Running ? task : nil);
            break;
        }
    }

    return status;
}

- (id<NSFastEnumeration>)children {
    return _children;
}

@end
