//
// nod - Copyright 2012 Three Rings Design

#import "GMTask.h"

@class GMBlackboard;

@interface GMRemoveBlackboardKeyAction : GMTask {
@protected
    __weak GMBlackboard* _blackboard;
    NSString* _key;
}

- (id)initWithName:(NSString*)name blackboard:(GMBlackboard*)blackboard key:(NSString*)key;

@end
