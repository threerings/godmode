//
// godmode - Copyright 2012 Three Rings Design

#import "GMTask.h"

/// A task that always returns Success
@interface GMNoOpAction : GMTask
+ (GMNoOpAction*)noOp;
@end
