//
// nod - Copyright 2012 Three Rings Design

#import "SequenceSelector.h"
#import "StatefulBehaviorTask+Protected.h"

@implementation SequenceSelector

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
    if (_curChild != nil) {
        [_curChild deactivate];
        _curChild = nil;
    }
    _childIdx = 0;
}

- (BehaviorStatus)update:(float)dt {
    while (_childIdx < _children.count) {
        _curChild = [_children objectAtIndex:_childIdx];
        BehaviorStatus childStatus = [_curChild updateTree:dt];
        if (childStatus == BehaviorSuccess) {
            // the child completed. Move on the to the next one.
            _curChild = nil;
            _childIdx++;
        } else {
            // RUNNING or FAIL return immediately
            return childStatus;
        }
    }

    // All our children have completed successfully
    return BehaviorSuccess;
}

- (id<NSFastEnumeration>)children {
    return _children;
}

@end
