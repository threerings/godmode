//
// godmode - Copyright 2012 Three Rings Design

#import "GMLoopingDecorator.h"
#import "GMWeightedSelector.h"
#import "GMSemaphore.h"
#import "GMPredicate.h"

@class GMBlackboard;

@interface GMTaskFactory : NSObject

/// Runs the given task if its predicates succeed
- (GMTask*)named:(NSString*)name if:(GMPredicate*)pred do:(GMTask*)task;
- (GMTask*)if:(GMPredicate*)pred do:(GMTask*)task;

/// Runs tasks in sequence until one fails, or all succeed.
- (GMTask*)named:(NSString*)name sequence:(NSArray*)children;
- (GMTask*)sequence:(NSArray*)children;

/// Run all tasks concurrently until one fails
- (GMTask*)named:(NSString*)name parallel:(NSArray*)children;
- (GMTask*)parallel:(NSArray*)children;

/// Loops a task forever
- (GMTask*)named:(NSString*)name loop:(GMTask*)task;
- (GMTask*)loop:(GMTask*)task;

/// Loops a task a specified number of times
- (GMTask*)named:(NSString*)name withLoopCount:(int)loopCount loop:(GMTask*)task;
- (GMTask*)withLoopCount:(int)loopCount loop:(GMTask*)task;

/// Loops a task until a condition is met
- (GMTask*)named:(NSString*)name withLoopType:(GMLoopType)loopType loop:(GMTask*)task;
- (GMTask*)withLoopType:(GMLoopType)loopType loop:(GMTask*)task;

/// Runs a task, and ensures that it won't be re-run until a minimum amount of time has elapsed
- (GMTask*)named:(NSString*)name withRepeatDelay:(OOOFloatRange*)minDelay do:(GMTask*)task;
- (GMTask*)withRepeatDelay:(OOOFloatRange*)minDelay do:(GMTask*)task;

/// Runs the first task that returns a non FAIL state. Higher-priority tasks (those higher in the list)
/// can interrupt lower-priority tasks that are running.
- (GMTask*)named:(NSString*)name selectWithPriority:(NSArray*)children;
- (GMTask*)selectWithPriority:(NSArray*)children;

/// Randomly selects a task to run
- (GMTask*)named:(NSString*)name withRands:(OOORandoms*)rands selectWithWeight:(NSArray*)weightedChildren;
- (GMTask*)withRands:(OOORandoms*)rands selectWithWeight:(NSArray*)weightedChildren;

/// Waits a specified amount of time
- (GMTask*)named:(NSString*)name wait:(float)time;
- (GMTask*)wait:(float)time;

/// Runs a block
- (GMTask*)named:(NSString*)name block:(GMStatus(^)(float dt))block;
- (GMTask*)block:(GMStatus(^)(float dt))block;

/// Runs a task, and sets a flag while it's running
- (GMTask*)named:(NSString*)name withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(GMTask*)task;
- (GMTask*)withFlags:(OOOMutableFlags*)flags setFlag:(int)flag while:(GMTask*)task;

/// Removes a key from a blackboard
- (GMTask*)named:(NSString*)name removeKey:(NSString*)key fromBlackboard:(GMBlackboard*)blackboard;
- (GMTask*)removeKey:(NSString*)key fromBlackboard:(GMBlackboard*)blackboard;

/// Runs a task if the given semaphore is successfully acquired
- (GMTask*)named:(NSString*)name withGuard:(GMSemaphore*)semaphore do:(GMTask*)task;
- (GMTask*)withGuard:(GMSemaphore*)semaphore do:(GMTask*)task;

/// Creates a new GMSemaphore
- (GMSemaphore*)createSemaphore:(NSString*)name maxUsers:(int)maxUsers;
- (GMSemaphore*)createMutex:(NSString*)name;

/// Does nothing
- (GMTask*)noOp;

/// Succeeds if the given flag is set
- (GMPredicate*)named:(NSString*)name withFlags:(OOOFlags*)flags isFlagSet:(int)flag;
- (GMPredicate*)withFlags:(OOOFlags*)flags isFlagSet:(int)flag;

/// GMPredicate block
- (GMPredicate*)named:(NSString*)name pred:(BOOL(^)())pred;
- (GMPredicate*)pred:(BOOL(^)())pred;

/// GMPredicate operators
- (GMPredicate*)named:(NSString*)name not:(GMPredicate*)pred;
- (GMPredicate*)named:(NSString*)name and:(NSArray*)preds;
- (GMPredicate*)named:(NSString*)name or:(NSArray*)preds;
- (GMPredicate*)not:(GMPredicate*)pred;
- (GMPredicate*)and:(NSArray*)preds;
- (GMPredicate*)or:(NSArray*)preds;


// abstract. Subclasses must override.
- (float)curTime;

@end