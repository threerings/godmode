//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

@class GMPredicate;

@interface GMPredicateFilter : GMStatefulTask <GMTaskContainer> {
@protected
    GMPredicate* _pred;
    GMTask* _task;
}

- (id)initWithName:(NSString*)name pred:(GMPredicate*)pred task:(GMTask*)task;

@end
