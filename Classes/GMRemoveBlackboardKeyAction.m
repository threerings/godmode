//
// godmode - Copyright 2012 Three Rings Design

#import "GMRemoveBlackboardKeyAction.h"
#import "GMTask+Protected.h"
#import "GMBlackboard.h"

@implementation GMRemoveBlackboardKeyAction

- (id)initWithName:(NSString*)name blackboard:(GMBlackboard*)blackboard key:(NSString*)key {
    if ((self = [super initWithName:name])) {
        _blackboard = blackboard;
        _key = key;
    }
    return self;
}

- (GMStatus)update:(float)dt {
    GMBlackboard* bb = _blackboard;
    if (bb == nil) {
        return GM_Fail;
    }

    [bb removeKey:_key];
    return GM_Success;
}

@end
