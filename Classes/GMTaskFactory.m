//
// godmode - Copyright 2012 Three Rings Design

#import "GMTaskFactory.h"

#import "GMDefs.h"
#import "GMRandoms.h"
#import "GMFloatRange.h"

#import "GMNotDecorator.h"
#import "GMParallelSelector.h"
#import "GMPrioritySelector.h"
#import "GMSequenceSelector.h"
#import "GMTimerAction.h"
#import "GMBlockTask.h"
#import "GMNoOpAction.h"
#import "GMDelayFilter.h"
#import "GMSemaphoreGuardDecorator.h"
#import "GMPredicateFilter.h"
#import "GMRemoveBlackboardKeyAction.h"

@implementation GMTaskFactory

- (float)curTime {
    GM_IS_ABSTRACT();
    return 0;
}

/// Preconditions
- (GMTask*)named:(NSString*)name if:(GMPredicate*)pred do:(GMTask*)task {
    return [[GMPredicateFilter alloc] initWithName:name pred:pred task:task];
}

- (GMTask*)if:(GMPredicate*)pred do:(GMTask*)task {
    return [[GMPredicateFilter alloc] initWithName:nil pred:pred task:task];
}

/// Delay
- (GMTask*)named:(NSString*)name withRepeatDelay:(GMFloatRange*)minDelay do:(GMTask*)task {
    return [[GMDelayFilter alloc] initWithName:name
                                    minDelay:minDelay
                                timeCallback:^float{ return [self curTime]; }
                                        task:task];
}

- (GMTask*)withRepeatDelay:(GMFloatRange*)minDelay do:(GMTask*)task {
    return [self named:nil withRepeatDelay:minDelay do:task];
}

/// Sequence
- (GMTask*)named:(NSString*)name sequence:(NSArray*)children {
    return [[GMSequenceSelector alloc] initWithName:name children:children];
}

- (GMTask*)sequence:(NSArray*)children {
    return [[GMSequenceSelector alloc] initWithName:nil children:children];
}

/// Parallel
- (GMTask*)named:(NSString*)name parallel:(NSArray*)children {
    return [[GMParallelSelector alloc] initWithName:name type:GM_AllComplete children:children];
}

- (GMTask*)parallel:(NSArray*)children {
    return [[GMParallelSelector alloc] initWithName:nil type:GM_AllComplete children:children];
}

/// Loop forever
- (GMTask*)named:(NSString*)name loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:name type:GM_BreakNever loopCount:0 task:task];
}

- (GMTask*)loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:nil type:GM_BreakNever loopCount:0 task:task];
}

// Loop X Times
- (GMTask*)named:(NSString*)name withLoopCount:(int)loopCount loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:name type:GM_BreakNever loopCount:loopCount task:task];
}

- (GMTask*)withLoopCount:(int)loopCount loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:nil type:GM_BreakNever loopCount:loopCount task:task];
}

/// Loop until
- (GMTask*)named:(NSString*)name withLoopType:(GMLoopType)exitCondition loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:name type:exitCondition loopCount:0 task:task];
}

- (GMTask*)withLoopType:(GMLoopType)exitCondition loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:nil type:exitCondition loopCount:0 task:task];
}

/// Priority
- (GMTask*)named:(NSString*)name selectWithPriority:(NSArray*)children {
    return [[GMPrioritySelector alloc] initWithName:name children:children];
}

- (GMTask*)selectWithPriority:(NSArray*)children {
    return [[GMPrioritySelector alloc] initWithName:nil children:children];
}

/// Wait
- (GMTask*)named:(NSString*)name wait:(float)time {
    return [[GMTimerAction alloc] initWithName:name time:time];
}

- (GMTask*)wait:(float)time {
    return [[GMTimerAction alloc] initWithName:nil time:time];
}

/// Weighted
- (GMTask*)named:(NSString*)name withRng:(id<GMRng>)rng selectWithWeight:(NSArray*)weightedChildren {
    return [[GMWeightedSelector alloc] initWithName:name rng:rng children:weightedChildren];
}

- (GMTask*)withRng:(id<GMRng>)rng selectWithWeight:(NSArray*)weightedChildren {
    return [[GMWeightedSelector alloc] initWithName:nil rng:rng children:weightedChildren];
}

/// Block
- (GMTask*)named:(NSString*)name block:(GMStatus (^)(float))block {
    return [[GMBlockTask alloc] initWithName:name block:block];
}

- (GMTask*)block:(GMStatus (^)(float))block {
    return [[GMBlockTask alloc] initWithName:nil block:block];
}

/// Remove Blackboard Key
- (GMTask*)named:(NSString*)name removeKey:(NSString*)key fromBlackboard:(GMBlackboard*)blackboard {
    return [[GMRemoveBlackboardKeyAction alloc] initWithName:name blackboard:blackboard key:key];
}

- (GMTask*)removeKey:(NSString*)key fromBlackboard:(GMBlackboard*)blackboard {
    return [[GMRemoveBlackboardKeyAction alloc] initWithName:nil blackboard:blackboard key:key];
}

/// Semaphore
- (GMTask*)named:(NSString*)name withGuard:(GMSemaphore*)semaphore do:(GMTask*)task {
    return [[GMSemaphoreGuardDecorator alloc] initWithName:name semaphore:semaphore task:task];
}

- (GMTask*)withGuard:(GMSemaphore*)semaphore do:(GMTask*)task {
    return [[GMSemaphoreGuardDecorator alloc] initWithName:nil semaphore:semaphore task:task];
}

- (GMSemaphore*)createSemaphore:(NSString*)name maxUsers:(int)maxUsers {
    return [[GMSemaphore alloc] initWithName:name maxUsers:maxUsers];
}

- (GMSemaphore*)createMutex:(NSString*)name {
    return [[GMSemaphore alloc] initWithName:name maxUsers:1];
}

/// No-op
- (GMTask*)noOp {
    return [[GMNoOpAction alloc] init];
}


/// Predicate: block
- (GMPredicate*)named:(NSString*)name pred:(BOOL(^)())pred {
    return [[GMBlockPredicate alloc] initWithName:name block:pred];
}

- (GMPredicate*)pred:(BOOL(^)())pred {
    return [[GMBlockPredicate alloc] initWithName:nil block:pred];
}

/// Predicate operators
- (GMPredicate*)named:(NSString*)name not:(GMPredicate*)pred {
    return [[GMNotPredicate alloc] initWithName:name pred:pred];
}

- (GMPredicate*)named:(NSString*)name and:(NSArray*)preds {
    return [[GMAndPredicate alloc] initWithName:name preds:preds];
}

- (GMPredicate*)named:(NSString*)name or:(NSArray*)preds {
    return [[GMOrPredicate alloc] initWithName:name preds:preds];
}

- (GMPredicate*)not:(GMPredicate*)pred {
    return [[GMNotPredicate alloc] initWithName:nil pred:pred];
}

- (GMPredicate*)and:(NSArray*)preds {
    return [[GMAndPredicate alloc] initWithName:nil preds:preds];
}

- (GMPredicate*)or:(NSArray*)preds {
    return [[GMOrPredicate alloc] initWithName:nil preds:preds];
}

@end
