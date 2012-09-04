//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorTask.h"
#import "BehaviorTaskContainer.h"

/// A behavior task that only returns Success or Fail
@interface BehaviorPredicate : BehaviorTask
// abstract. Subclasses override.
- (BOOL)evaluate;
@end

@interface NotBehaviorPredicate : BehaviorPredicate <BehaviorTaskContainer> {
@protected
    BehaviorPredicate* _pred;
}
- (id)initWithName:(NSString*)name pred:(BehaviorPredicate*)pred;
@end

@interface AndBehaviorPredicate : BehaviorPredicate <BehaviorTaskContainer> {
@protected
    NSArray* _preds;
}
- (id)initWithName:(NSString*)name preds:(NSArray*)preds;
@end

@interface OrBehaviorPredicate : BehaviorPredicate <BehaviorTaskContainer> {
@protected
    NSArray* _preds;
}
- (id)initWithName:(NSString*)name preds:(NSArray*)preds;
@end

@interface BlockBehaviorPredicate : BehaviorPredicate {
@protected
    BOOL (^_block)();
}
- (id)initWithName:(NSString*)name block:(BOOL(^)())pred;
@end
