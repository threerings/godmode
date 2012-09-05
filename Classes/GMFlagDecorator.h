//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

/// A Decorator that sets a flag when its task begins, and clears it when the task ends.
@interface GMFlagDecorator : GMStatefulTask <GMTaskContainer> {
@protected
    GMTask* _task;
    OOOMutableFlags* _flags;
    int _flag;
}

- (id)initWithName:(NSString*)name flags:(OOOMutableFlags*)flags flag:(int)flag task:(GMTask*)task;

@end
