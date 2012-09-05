//
// godmode - Copyright 2012 Three Rings Design

#import "GMTask.h"

#define ENUM_STRING(val) case val: return @#val;

@interface GMTask (protected)

/// Subclasses should override this function to update the behavior logic.
- (GMStatus)update:(float)dt;

- (NSString*)description;
- (NSString*)statusString;

@end