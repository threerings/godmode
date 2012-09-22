//
// godmode - Copyright 2012 Three Rings Design

#import "GMSequenceSelector.h"
#import "GMStatefulTask+Protected.h"

@implementation GMSequenceSelector

- (id)initWithName:(NSString*)name children:(NSArray*)children {
    if ((self = [super initWithName:name])) {
        _children = children;
    }
    return self;
}

- (void)reset {
    if (_curChild != nil) {
        [_curChild deactivate];
        _curChild = nil;
    }
    _childIdx = 0;
}

- (GMStatus)update:(float)dt {
    while (_childIdx < _children.count) {
        _curChild = _children[_childIdx];
        GMStatus childStatus = [_curChild updateTree:dt];
        if (childStatus == GM_Success) {
            // the child completed. Move on the to the next one.
            _curChild = nil;
            _childIdx++;
        } else {
            // RUNNING or FAIL return immediately
            return childStatus;
        }
    }

    // All our children have completed successfully
    return GM_Success;
}

- (id<NSFastEnumeration>)children {
    return _children;
}

@end
