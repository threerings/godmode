//
// godmode - Copyright 2012 Three Rings Design

#import "GMStatefulTask.h"
#import "GMTaskContainer.h"

typedef enum {
    GM_AllSuccess = 0,  // SUCCESS if all succeed. FAIL if any fail.
    GM_AnySuccess,      // SUCCESS if any succeed. FAIL if all fail.
    GM_AllFail,         // SUCCESS if all fail. FAIL if any succeed.
    GM_AnyFail,         // SUCCESS if any fail. FAIL if all succeed.
    GM_AllComplete,     // SUCCESS when all succeed or fail.
    GM_AnyComplete      // SUCCESS when any succeeds or fails.
} GMParallelSelectorType;


/// A selector that executes all children, every update, until a condition is met.
@interface GMParallelSelector : GMStatefulTask <GMTaskContainer> {
    GMParallelSelectorType _type;
    NSArray* _children;
}

- (id)initWithName:(NSString*)name type:(GMParallelSelectorType)type children:(NSArray*)children;

@end
