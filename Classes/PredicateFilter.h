//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

@class BehaviorPredicate;

@interface PredicateFilter : StatefulBehaviorTask <BehaviorTaskContainer> {
@protected
    BehaviorPredicate* _pred;
    BehaviorTask* _task;
}

- (id)initWithName:(NSString*)name pred:(BehaviorPredicate*)pred task:(BehaviorTask*)task;

@end
