//
// godmode - Copyright 2012 Three Rings Design

#import "GMParallelSelector.h"
#import "GMStatefulTask+Protected.h"

static NSString* GetTypeString (GMParallelSelectorType type) {
    switch (type) {
        ENUM_STRING(GM_AllSuccess);
        ENUM_STRING(GM_AnySuccess);
        ENUM_STRING(GM_AllFail);
        ENUM_STRING(GM_AnyFail);
        ENUM_STRING(GM_AllComplete);
        ENUM_STRING(GM_AnyComplete);
    }
}

@implementation GMParallelSelector

- (id)initWithName:(NSString*)name type:(GMParallelSelectorType)type children:(NSArray*)children {
    if ((self = [super initWithName:name])) {
        _type = type;
        _children = children;
    }
    return self;
}

- (void)reset {
    for (GMTask* child in _children) {
        [child deactivate];
    }
}

- (GMStatus)update:(float)dt {
    BOOL runningChildren = NO;
    for (GMTask* child in _children) {
        GMStatus childStatus = [child updateTree:dt];
        if (childStatus == GM_Success) {
            if (_type == GM_AnySuccess || _type == GM_AnyComplete) {
                return GM_Success;
            } else if (_type == GM_AllFail) {
                return GM_Fail;
            }

        } else if (childStatus == GM_Fail) {
            if (_type == GM_AnyFail || _type == GM_AnyComplete) {
                return GM_Success;
            } else if (_type == GM_AllSuccess) {
                return GM_Fail;
            }
        } else {
            runningChildren = YES;
        }
    }

    return (runningChildren ? GM_Running : GM_Success);
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@:%@", [super description], GetTypeString(_type)];
}

- (id<NSFastEnumeration>)children {
    return _children;
}

@end
