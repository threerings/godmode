//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorTask+Protected.h"
#import "BehaviorTaskPrinter.h"

static NSString* GetStatusString (BehaviorStatus status) {
    switch (status) {
    case BehaviorRunning:   return @"RUNNING";
    case BehaviorSuccess:   return @"SUCCESS";
    case BehaviorFail:      return @"FAIL";
    default:                return @"NEVER_RUN";
    }
}

@implementation BehaviorTask

- (id)init {
    return [self initWithName:nil];
}

- (id)initWithName:(NSString*)name {
    if ((self = [super init])) {
        _name = name;
    }
    return self;
}

- (BehaviorStatus)updateTree:(float)dt {
    _lastStatus = [self update:dt];
    return _lastStatus;
}

- (BehaviorStatus)update:(float)dt { return BehaviorSuccess; }

- (void)deactivate {}

- (NSString*)statusString {
    return GetStatusString(_lastStatus);
}

- (NSString*)description {
    NSString* className = NSStringFromClass([self class]);
    if (_name != nil) {
        return [NSString stringWithFormat:@"\"%@\" %@", _name, className];
    } else {
        return className;
    }
}

- (NSString*)printTreeState {
    BehaviorTaskPrinter* printer = [[BehaviorTaskPrinter alloc] initWithTask:self];
    return printer.description;
}

@end
