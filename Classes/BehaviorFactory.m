//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorFactory.h"
#import "NotDecorator.h"
#import "ParallelSelector.h"
#import "PrioritySelector.h"
#import "SequenceSelector.h"
#import "TimerAction.h"
#import "BlockTask.h"
#import "NoOpAction.h"
#import "DelayFilter.h"
#import "SemaphoreGuardDecorator.h"
#import "PredicateFilter.h"
#import "FlagDecorator.h"
#import "RemoveBlackboardKeyAction.h"

#import "FlagSetPredicate.h"

@implementation BehaviorFactory

- (float)curTime {
    OOO_IS_ABSTRACT();
    return 0;
}

/// Preconditions
- (BehaviorTask*)named:(NSString*)name if:(BehaviorPredicate*)pred do:(BehaviorTask*)task {
    return [[PredicateFilter alloc] initWithName:name pred:pred task:task];
}

- (BehaviorTask*)if:(BehaviorPredicate*)pred do:(BehaviorTask*)task {
    return [[PredicateFilter alloc] initWithName:nil pred:pred task:task];
}

/// Delay
- (BehaviorTask*)named:(NSString*)name withRepeatDelay:(OOOFloatRange*)minDelay do:(BehaviorTask*)task {
    return [[DelayFilter alloc] initWithName:name
                                    minDelay:minDelay
                                timeCallback:^float{ return [self curTime]; }
                                        task:task];
}

- (BehaviorTask*)withRepeatDelay:(OOOFloatRange*)minDelay do:(BehaviorTask*)task {
    return [self named:nil withRepeatDelay:minDelay do:task];
}

/// Sequence
- (BehaviorTask*)named:(NSString*)name sequence:(BehaviorTask*)child, ... {
    return [[SequenceSelector alloc] initWithName:name children:OOO_VARARGS_TO_ARRAY(BehaviorTask*, child)];
}

- (BehaviorTask*)sequence:(BehaviorTask*)child, ... {
    return [[SequenceSelector alloc] initWithChildren:OOO_VARARGS_TO_ARRAY(BehaviorTask*, child)];
}

/// Parallel
- (BehaviorTask*)named:(NSString*)name parallel:(BehaviorTask*)child, ... {
    return [[ParallelSelector alloc] initWithName:name until:PEC_ALL_COMPLETE children:OOO_VARARGS_TO_ARRAY(BehaviorTask*, child)];
}

- (BehaviorTask*)parallel:(BehaviorTask*)child, ... {
    return [[ParallelSelector alloc] init:PEC_ALL_COMPLETE children:OOO_VARARGS_TO_ARRAY(BehaviorTask*, child)];
}

/// Loop forever
- (BehaviorTask*)named:(NSString*)name loop:(BehaviorTask*)task {
    return [[LoopingDecorator alloc] initWithName:name breakCondition:LoopBreakNone loopCount:0 task:task];
}

- (BehaviorTask*)loop:(BehaviorTask*)task {
    return [[LoopingDecorator alloc] initWithName:nil breakCondition:LoopBreakNone loopCount:0 task:task];
}

// Loop X Times
- (BehaviorTask*)named:(NSString*)name withLoopCount:(int)loopCount loop:(BehaviorTask*)task {
    return [[LoopingDecorator alloc] initWithName:name breakCondition:LoopBreakNone loopCount:loopCount task:task];
}

- (BehaviorTask*)withLoopCount:(int)loopCount loop:(BehaviorTask*)task {
    return [[LoopingDecorator alloc] initWithName:nil breakCondition:LoopBreakNone loopCount:loopCount task:task];
}

/// Loop until
- (BehaviorTask*)named:(NSString*)name withBreakCondition:(LoopBreakCondition)exitCondition loop:(BehaviorTask*)task {
    return [[LoopingDecorator alloc] initWithName:name breakCondition:exitCondition loopCount:0 task:task];
}

- (BehaviorTask*)withBreakCondition:(LoopBreakCondition)exitCondition loop:(BehaviorTask*)task {
    return [[LoopingDecorator alloc] initWithName:nil breakCondition:exitCondition loopCount:0 task:task];
}

/// Priority
- (BehaviorTask*)named:(NSString*)name selectWithPriority:(BehaviorTask*)child, ... {
    return [[PrioritySelector alloc] initWithName:name children:OOO_VARARGS_TO_ARRAY(BehaviorTask*, child)];
}

- (BehaviorTask*)selectWithPriority:(BehaviorTask*)child, ... {
    return [[PrioritySelector alloc] initWithChildren:OOO_VARARGS_TO_ARRAY(BehaviorTask*, child)];
}

/// Wait
- (BehaviorTask*)named:(NSString*)name wait:(float)time {
    return [[TimerAction alloc] initWithName:name time:time];
}

- (BehaviorTask*)wait:(float)time {
    return [[TimerAction alloc] initWithTime:time];
}

/// Weighted
- (BehaviorTask*)named:(NSString*)name withRands:(OOORandoms*)rands selectWithWeight:(WeightedTask*)child, ... {
    return [[WeightedSelector alloc] initWithName:name rands:rands children:OOO_VARARGS_TO_ARRAY(WeightedTask*, child)];
}

- (BehaviorTask*)withRands:(OOORandoms*)rands selectWithWeight:(WeightedTask*)child, ... {
    return [[WeightedSelector alloc] initWithRands:rands children:OOO_VARARGS_TO_ARRAY(WeightedTask*, child)];
}

/// Block
- (BehaviorTask*)named:(NSString*)name block:(BehaviorStatus (^)(float))block {
    return [[BlockTask alloc] initWithName:name block:block];
}

- (BehaviorTask*)block:(BehaviorStatus (^)(float))block {
    return [[BlockTask alloc] initWithBlock:block];
}

/// FlagDecorator
- (BehaviorTask*)named:(NSString*)name withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(BehaviorTask*)task {
    return [[FlagDecorator alloc] initWithName:name flags:flags flag:flag task:task];
}

- (BehaviorTask*)withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(BehaviorTask*)task {
    return [[FlagDecorator alloc] initWithName:nil flags:flags flag:flag task:task];
}

/// Remove Blackboard Key
- (BehaviorTask*)named:(NSString*)name removeKey:(NSString*)key fromBlackboard:(Blackboard*)blackboard {
    return [[RemoveBlackboardKeyAction alloc] initWithName:name blackboard:blackboard key:key];
}

- (BehaviorTask*)removeKey:(NSString*)key fromBlackboard:(Blackboard*)blackboard {
    return [[RemoveBlackboardKeyAction alloc] initWithName:nil blackboard:blackboard key:key];
}

/// Semaphore
- (BehaviorTask*)named:(NSString*)name withGuard:(BehaviorSemaphore*)semaphore do:(BehaviorTask*)task {
    return [[SemaphoreGuardDecorator alloc] initWithName:name semaphore:semaphore task:task];
}

- (BehaviorTask*)withGuard:(BehaviorSemaphore*)semaphore do:(BehaviorTask*)task {
    return [[SemaphoreGuardDecorator alloc] initWithName:nil semaphore:semaphore task:task];
}

- (BehaviorSemaphore*)createSemaphore:(NSString*)name maxUsers:(int)maxUsers {
    return [[BehaviorSemaphore alloc] initWithName:name maxUsers:maxUsers];
}

- (BehaviorSemaphore*)createMutex:(NSString*)name {
    return [[BehaviorSemaphore alloc] initWithName:name maxUsers:1];
}

/// No-op
- (BehaviorTask*)noOp {
    return [[NoOpAction alloc] init];
}

/// Predicate: IsFlagSet
- (BehaviorPredicate*)named:(NSString*)name withFlags:(OOOFlags*)flags isFlagSet:(int)flag {
    return [[FlagSetPredicate alloc] initWithName:name flags:flags flag:flag];
}

- (BehaviorPredicate*)withFlags:(OOOFlags*)flags isFlagSet:(int)flag {
    return [[FlagSetPredicate alloc] initWithName:nil flags:flags flag:flag];
}

/// Predicate: block
- (BehaviorPredicate*)named:(NSString*)name pred:(BOOL(^)())pred {
    return [[BlockBehaviorPredicate alloc] initWithName:name block:pred];
}

- (BehaviorPredicate*)pred:(BOOL(^)())pred {
    return [[BlockBehaviorPredicate alloc] initWithName:nil block:pred];
}

/// Predicate operators
- (BehaviorPredicate*)named:(NSString*)name not:(BehaviorPredicate*)pred {
    return [[NotBehaviorPredicate alloc] initWithName:name pred:pred];
}

- (BehaviorPredicate*)named:(NSString*)name and:(BehaviorPredicate*)pred, ... {
    return [[AndBehaviorPredicate alloc] initWithName:name preds:OOO_VARARGS_TO_ARRAY(BehaviorPredicate*, pred)];
}

- (BehaviorPredicate*)named:(NSString*)name or:(BehaviorPredicate*)pred, ... {
    return [[OrBehaviorPredicate alloc] initWithName:name preds:OOO_VARARGS_TO_ARRAY(BehaviorPredicate*, pred)];
}

- (BehaviorPredicate*)not:(BehaviorPredicate*)pred {
    return [[NotBehaviorPredicate alloc] initWithName:nil pred:pred];
}

- (BehaviorPredicate*)and:(BehaviorPredicate*)pred, ... {
    return [[AndBehaviorPredicate alloc] initWithName:nil preds:OOO_VARARGS_TO_ARRAY(BehaviorPredicate*, pred)];
}

- (BehaviorPredicate*)or:(BehaviorPredicate*)pred, ... {
    return [[OrBehaviorPredicate alloc] initWithName:nil preds:OOO_VARARGS_TO_ARRAY(BehaviorPredicate*, pred)];
}

@end
