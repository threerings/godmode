//
// nod - Copyright 2012 Three Rings Design

#import "StatefulBehaviorTask.h"
#import "BehaviorTaskContainer.h"

typedef enum {
    PEC_ALL_SUCCESS,    // SUCCESS if all succeed. FAIL if any fail.
    PEC_ANY_SUCCESS,    // SUCCESS if any succeed. FAIL if all fail.
    PEC_ALL_FAIL,       // SUCCESS if all fail. FAIL if any succeed.
    PEC_ANY_FAIL,       // SUCCESS if any fail. FAIL if all succeed.
    PEC_ALL_COMPLETE,   // SUCCESS when all succeed or fail.
    PEC_ANY_COMPLETE    // SUCCESS when any succeeds or fails.
} ParallelExitCondition;


/// A selector that executes all children, every update, until a condition is met.
@interface ParallelSelector : StatefulBehaviorTask <BehaviorTaskContainer> {
    ParallelExitCondition _until;
    NSArray* _children;
}

- (id)initWithName:(NSString*)name until:(ParallelExitCondition)until children:(NSArray*)children;
- (id)init:(ParallelExitCondition)until children:(NSArray*)children;

@end
