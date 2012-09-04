//
// nod - Copyright 2012 Three Rings Design

#import "LoopingDecorator.h"
#import "WeightedSelector.h"
#import "BehaviorSemaphore.h"
#import "BehaviorPredicate.h"

@class Blackboard;
@protocol IFloatValue;
@protocol IObjectValue;

@interface BehaviorFactory : NSObject

/// Runs the given task if its predicates succeed
- (BehaviorTask*)named:(NSString*)name if:(BehaviorPredicate*)pred do:(BehaviorTask*)task;
- (BehaviorTask*)if:(BehaviorPredicate*)pred do:(BehaviorTask*)task;

/// Runs tasks in sequence until one fails, or all succeed.
- (BehaviorTask*)named:(NSString*)name sequence:(BehaviorTask*)child, ... NS_REQUIRES_NIL_TERMINATION;
- (BehaviorTask*)sequence:(BehaviorTask*)child, ... NS_REQUIRES_NIL_TERMINATION;

/// Run all tasks concurrently until one fails
- (BehaviorTask*)named:(NSString*)name parallel:(BehaviorTask*)child, ... NS_REQUIRES_NIL_TERMINATION;
- (BehaviorTask*)parallel:(BehaviorTask*)child, ... NS_REQUIRES_NIL_TERMINATION;

/// Loops a task forever
- (BehaviorTask*)named:(NSString*)name loop:(BehaviorTask*)task;
- (BehaviorTask*)loop:(BehaviorTask*)task;

/// Loops a task a specified number of times
- (BehaviorTask*)named:(NSString*)name withLoopCount:(int)loopCount loop:(BehaviorTask*)task;
- (BehaviorTask*)withLoopCount:(int)loopCount loop:(BehaviorTask*)task;

/// Loops a task until a condition is met
- (BehaviorTask*)named:(NSString*)name withBreakCondition:(LoopBreakCondition)exitCondition loop:(BehaviorTask*)task;
- (BehaviorTask*)withBreakCondition:(LoopBreakCondition)exitCondition loop:(BehaviorTask*)task;

/// Runs a task, and ensures that it won't be re-run until a minimum amount of time has elapsed
- (BehaviorTask*)named:(NSString*)name withRepeatDelay:(OOOFloatRange*)minDelay do:(BehaviorTask*)task;
- (BehaviorTask*)withRepeatDelay:(OOOFloatRange*)minDelay do:(BehaviorTask*)task;

/// Runs the first task that returns a non FAIL state. Higher-priority tasks (those higher in the list)
/// can interrupt lower-priority tasks that are running.
- (BehaviorTask*)named:(NSString*)name selectWithPriority:(BehaviorTask*)child, ... NS_REQUIRES_NIL_TERMINATION;
- (BehaviorTask*)selectWithPriority:(BehaviorTask*)child, ... NS_REQUIRES_NIL_TERMINATION;

/// Randomly selects a task to run
- (BehaviorTask*)named:(NSString*)name withRands:(OOORandoms*)rands selectWithWeight:(WeightedTask*)child, ... NS_REQUIRES_NIL_TERMINATION;
- (BehaviorTask*)withRands:(OOORandoms*)rands selectWithWeight:(WeightedTask*)child, ... NS_REQUIRES_NIL_TERMINATION;

/// Waits a specified amount of time
- (BehaviorTask*)named:(NSString*)name wait:(float)time;
- (BehaviorTask*)wait:(float)time;

/// Runs a block
- (BehaviorTask*)named:(NSString*)name block:(BehaviorStatus(^)(float dt))block;
- (BehaviorTask*)block:(BehaviorStatus(^)(float dt))block;

/// Runs a task, and sets a flag while it's running
- (BehaviorTask*)named:(NSString*)name withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(BehaviorTask*)task;
- (BehaviorTask*)withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(BehaviorTask*)task;

/// Removes a key from a blackboard
- (BehaviorTask*)named:(NSString*)name removeKey:(NSString*)key fromBlackboard:(Blackboard*)blackboard;
- (BehaviorTask*)removeKey:(NSString*)key fromBlackboard:(Blackboard*)blackboard;

/// Runs a task if the given semaphore is successfully acquired
- (BehaviorTask*)named:(NSString*)name withGuard:(BehaviorSemaphore*)semaphore do:(BehaviorTask*)task;
- (BehaviorTask*)withGuard:(BehaviorSemaphore*)semaphore do:(BehaviorTask*)task;

/// Creates a new BehaviorSemaphore
- (BehaviorSemaphore*)createSemaphore:(NSString*)name maxUsers:(int)maxUsers;
- (BehaviorSemaphore*)createMutex:(NSString*)name;

/// Does nothing
- (BehaviorTask*)noOp;

/// Succeeds if the given flag is set
- (BehaviorPredicate*)named:(NSString*)name withFlags:(OOOFlags*)flags isFlagSet:(int)flag;
- (BehaviorPredicate*)withFlags:(OOOFlags*)flags isFlagSet:(int)flag;

/// Removes a key from a blackboard
- (BehaviorTask*)named:(NSString*)name removeKey:(NSString*)key fromBlackboard:(Blackboard*)blackboard;
- (BehaviorTask*)removeKey:(NSString*)key fromBlackboard:(Blackboard*)blackboard;

/// BehaviorPredicate block
- (BehaviorPredicate*)named:(NSString*)name pred:(BOOL(^)())pred;
- (BehaviorPredicate*)pred:(BOOL(^)())pred;

/// BehaviorPredicate operators
- (BehaviorPredicate*)named:(NSString*)name not:(BehaviorPredicate*)pred;
- (BehaviorPredicate*)named:(NSString*)name and:(BehaviorPredicate*)pred, ... NS_REQUIRES_NIL_TERMINATION;
- (BehaviorPredicate*)named:(NSString*)name or:(BehaviorPredicate*)pred, ... NS_REQUIRES_NIL_TERMINATION;
- (BehaviorPredicate*)not:(BehaviorPredicate*)pred;
- (BehaviorPredicate*)and:(BehaviorPredicate*)pred, ... NS_REQUIRES_NIL_TERMINATION;
- (BehaviorPredicate*)or:(BehaviorPredicate*)pred, ... NS_REQUIRES_NIL_TERMINATION;


// abstract. Subclasses must override.
- (float)curTime;

@end