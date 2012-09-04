//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorPredicate.h"

/// Evaluates to YES if the given flag is set
@interface FlagSetPredicate : BehaviorPredicate {
@protected
    OOOFlags* _flags;
    int _flag;
}

- (id)initWithName:(NSString*)name flags:(OOOFlags*)flags flag:(int)flag;

@end
