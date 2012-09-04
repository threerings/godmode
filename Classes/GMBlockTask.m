//
// nod - Copyright 2012 Three Rings Design

#import "GMBlockTask.h"

@implementation GMBlockTask

- (id)initWithName:(NSString*)name block:(BehaviorTaskBlock)block {
    if ((self = [super initWithName:name])) {
        _block = [block copy];
    }
    return self;
}

- (id)initWithBlock:(BehaviorTaskBlock)block {
    return [self initWithName:nil block:block];
}

- (BehaviorStatus)update:(float)dt {
    return _block(dt);
}

@end
