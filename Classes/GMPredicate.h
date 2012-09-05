//
// godmode - Copyright 2012 Three Rings Design

#import "GMTask.h"
#import "GMTaskContainer.h"

/// A behavior task that only returns Success or Fail
@interface GMPredicate : GMTask
// abstract. Subclasses override.
- (BOOL)evaluate;
@end

@interface GMNotPredicate : GMPredicate <GMTaskContainer> {
@protected
    GMPredicate* _pred;
}
- (id)initWithName:(NSString*)name pred:(GMPredicate*)pred;
@end

@interface GMAndPredicate : GMPredicate <GMTaskContainer> {
@protected
    NSArray* _preds;
}
- (id)initWithName:(NSString*)name preds:(NSArray*)preds;
@end

@interface GMOrPredicate : GMPredicate <GMTaskContainer> {
@protected
    NSArray* _preds;
}
- (id)initWithName:(NSString*)name preds:(NSArray*)preds;
@end

@interface GMBlockPredicate : GMPredicate {
@protected
    BOOL (^_block)();
}
- (id)initWithName:(NSString*)name block:(BOOL(^)())pred;
@end
