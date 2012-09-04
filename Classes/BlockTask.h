//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorTask.h"

typedef BehaviorStatus (^BehaviorTaskBlock)(float dt);

/// A task that runs a block
@interface BlockTask : BehaviorTask {
@protected
    BehaviorTaskBlock _block;
}

- (id)initWithName:(NSString*)name block:(BehaviorTaskBlock)block;
- (id)initWithBlock:(BehaviorTaskBlock)block;

@end
