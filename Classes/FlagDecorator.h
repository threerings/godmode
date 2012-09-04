//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

/// A Decorator that sets a flag when its task begins, and clears it when the task ends.
@interface FlagDecorator : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    BehaviorTask* _task;
    OOOMutableFlags* _flags;
    int _flag;
}

- (id)initWithName:(NSString*)name flags:(OOOMutableFlags*)flags flag:(int)flag task:(BehaviorTask*)task;

@end
