//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorTask.h"

@class Blackboard;

@interface RemoveBlackboardKeyAction : BehaviorTask {
@protected
    __weak Blackboard* _blackboard;
    NSString* _key;
}

- (id)initWithName:(NSString*)name blackboard:(Blackboard*)blackboard key:(NSString*)key;

@end
