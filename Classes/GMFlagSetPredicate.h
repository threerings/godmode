//
// nod - Copyright 2012 Three Rings Design

#import "GMPredicate.h"

/// Evaluates to YES if the given flag is set
@interface GMFlagSetPredicate : GMPredicate {
@protected
    OOOFlags* _flags;
    int _flag;
}

- (id)initWithName:(NSString*)name flags:(OOOFlags*)flags flag:(int)flag;

@end
