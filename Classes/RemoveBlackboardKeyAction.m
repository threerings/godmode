//
// nod - Copyright 2012 Three Rings Design

#import "RemoveBlackboardKeyAction.h"
#import "BehaviorTask+Protected.h"
#import "Blackboard.h"

@implementation RemoveBlackboardKeyAction

- (id)initWithName:(NSString*)name blackboard:(Blackboard*)blackboard key:(NSString*)key {
    if ((self = [super initWithName:name])) {
        _blackboard = blackboard;
        _key = key;
    }
    return self;
}

- (BehaviorStatus)update:(float)dt {
    Blackboard* bb = _blackboard;
    if (bb == nil) {
        return BehaviorFail;
    }

    [bb removeKey:_key];
    return BehaviorSuccess;
}

@end
