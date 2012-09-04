//
// nod - Copyright 2012 Three Rings Design

#import "GMBehaviorFactory.h"
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
#import "GMFlagDecorator.h"
#import "GMRemoveBlackboardKeyAction.h"

#import "GMFlagSetPredicate.h"

@implementation GMBehaviorFactory

- (float)curTime {
    OOO_IS_ABSTRACT();
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
- (GMTask*)named:(NSString*)name withRepeatDelay:(OOOFloatRange*)minDelay do:(GMTask*)task {
    return [[GMDelayFilter alloc] initWithName:name
                                    minDelay:minDelay
                                timeCallback:^float{ return [self curTime]; }
                                        task:task];
}

- (GMTask*)withRepeatDelay:(OOOFloatRange*)minDelay do:(GMTask*)task {
    return [self named:nil withRepeatDelay:minDelay do:task];
}

/// Sequence
- (GMTask*)named:(NSString*)name sequence:(GMTask*)child, ... {
    return [[GMSequenceSelector alloc] initWithName:name children:OOO_VARARGS_TO_ARRAY(GMTask*, child)];
}

- (GMTask*)sequence:(GMTask*)child, ... {
    return [[GMSequenceSelector alloc] initWithChildren:OOO_VARARGS_TO_ARRAY(GMTask*, child)];
}

/// Parallel
- (GMTask*)named:(NSString*)name parallel:(GMTask*)child, ... {
    return [[GMParallelSelector alloc] initWithName:name until:PEC_ALL_COMPLETE children:OOO_VARARGS_TO_ARRAY(GMTask*, child)];
}

- (GMTask*)parallel:(GMTask*)child, ... {
    return [[GMParallelSelector alloc] init:PEC_ALL_COMPLETE children:OOO_VARARGS_TO_ARRAY(GMTask*, child)];
}

/// Loop forever
- (GMTask*)named:(NSString*)name loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:name breakCondition:LoopBreakNone loopCount:0 task:task];
}

- (GMTask*)loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:nil breakCondition:LoopBreakNone loopCount:0 task:task];
}

// Loop X Times
- (GMTask*)named:(NSString*)name withLoopCount:(int)loopCount loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:name breakCondition:LoopBreakNone loopCount:loopCount task:task];
}

- (GMTask*)withLoopCount:(int)loopCount loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:nil breakCondition:LoopBreakNone loopCount:loopCount task:task];
}

/// Loop until
- (GMTask*)named:(NSString*)name withBreakCondition:(LoopBreakCondition)exitCondition loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:name breakCondition:exitCondition loopCount:0 task:task];
}

- (GMTask*)withBreakCondition:(LoopBreakCondition)exitCondition loop:(GMTask*)task {
    return [[GMLoopingDecorator alloc] initWithName:nil breakCondition:exitCondition loopCount:0 task:task];
}

/// Priority
- (GMTask*)named:(NSString*)name selectWithPriority:(GMTask*)child, ... {
    return [[GMPrioritySelector alloc] initWithName:name children:OOO_VARARGS_TO_ARRAY(GMTask*, child)];
}

- (GMTask*)selectWithPriority:(GMTask*)child, ... {
    return [[GMPrioritySelector alloc] initWithChildren:OOO_VARARGS_TO_ARRAY(GMTask*, child)];
}

/// Wait
- (GMTask*)named:(NSString*)name wait:(float)time {
    return [[GMTimerAction alloc] initWithName:name time:time];
}

- (GMTask*)wait:(float)time {
    return [[GMTimerAction alloc] initWithTime:time];
}

/// Weighted
- (GMTask*)named:(NSString*)name withRands:(OOORandoms*)rands selectWithWeight:(WeightedTask*)child, ... {
    return [[GMWeightedSelector alloc] initWithName:name rands:rands children:OOO_VARARGS_TO_ARRAY(WeightedTask*, child)];
}

- (GMTask*)withRands:(OOORandoms*)rands selectWithWeight:(WeightedTask*)child, ... {
    return [[GMWeightedSelector alloc] initWithRands:rands children:OOO_VARARGS_TO_ARRAY(WeightedTask*, child)];
}

/// Block
- (GMTask*)named:(NSString*)name block:(BehaviorStatus (^)(float))block {
    return [[GMBlockTask alloc] initWithName:name block:block];
}

- (GMTask*)block:(BehaviorStatus (^)(float))block {
    return [[GMBlockTask alloc] initWithBlock:block];
}

/// FlagDecorator
- (GMTask*)named:(NSString*)name withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(GMTask*)task {
    return [[GMFlagDecorator alloc] initWithName:name flags:flags flag:flag task:task];
}

- (GMTask*)withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(GMTask*)task {
    return [[GMFlagDecorator alloc] initWithName:nil flags:flags flag:flag task:task];
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

/// Predicate: IsFlagSet
- (GMPredicate*)named:(NSString*)name withFlags:(OOOFlags*)flags isFlagSet:(int)flag {
    return [[GMFlagSetPredicate alloc] initWithName:name flags:flags flag:flag];
}

- (GMPredicate*)withFlags:(OOOFlags*)flags isFlagSet:(int)flag {
    return [[GMFlagSetPredicate alloc] initWithName:nil flags:flags flag:flag];
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

- (GMPredicate*)named:(NSString*)name and:(GMPredicate*)pred, ... {
    return [[GMAndPredicate alloc] initWithName:name preds:OOO_VARARGS_TO_ARRAY(GMPredicate*, pred)];
}

- (GMPredicate*)named:(NSString*)name or:(GMPredicate*)pred, ... {
    return [[GMOrPredicate alloc] initWithName:name preds:OOO_VARARGS_TO_ARRAY(GMPredicate*, pred)];
}

- (GMPredicate*)not:(GMPredicate*)pred {
    return [[GMNotPredicate alloc] initWithName:nil pred:pred];
}

- (GMPredicate*)and:(GMPredicate*)pred, ... {
    return [[GMAndPredicate alloc] initWithName:nil preds:OOO_VARARGS_TO_ARRAY(GMPredicate*, pred)];
}

- (GMPredicate*)or:(GMPredicate*)pred, ... {
    return [[GMOrPredicate alloc] initWithName:nil preds:OOO_VARARGS_TO_ARRAY(GMPredicate*, pred)];
}

@end
