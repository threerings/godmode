//
// nod - Copyright 2012 Three Rings Design

#import "GMTask.h"

/// A BehaviorTask that always returns SUCCESS
@interface GMNoOpAction : GMTask
+ (GMNoOpAction*)noOp;
@end
