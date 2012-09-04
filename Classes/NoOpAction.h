//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorTask.h"

/// A BehaviorTask that always returns SUCCESS
@interface NoOpAction : BehaviorTask
+ (NoOpAction*)noOp;
@end
