//
// godmode - Copyright 2012 Three Rings Design

#import "GMTask.h"

typedef GMStatus (^GMTaskBlock)(float dt);

/// A task that runs a block
@interface GMBlockTask : GMTask {
@protected
    GMTaskBlock _block;
}

- (id)initWithName:(NSString*)name block:(GMTaskBlock)block;
- (id)initWithBlock:(GMTaskBlock)block;

@end
