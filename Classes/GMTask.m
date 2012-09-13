//
// godmode - Copyright 2012 Three Rings Design

#import "GMTask+Protected.h"
#import "GMTaskPrinter.h"

static NSString* GetStatusString (GMStatus status) {
    switch (status) {
    case GM_Running:   return @"RUNNING";
    case GM_Success:   return @"SUCCESS";
    case GM_Fail:      return @"FAIL";
    default:           return @"NEVER_RUN";
    }
}

@implementation GMTask

- (id)init {
    return [self initWithName:nil];
}

- (id)initWithName:(NSString*)name {
    if ((self = [super init])) {
        _name = name;
    }
    return self;
}

- (GMStatus)updateTree:(float)dt {
    _lastStatus = [self update:dt];
    return _lastStatus;
}

- (GMStatus)update:(float)dt { return GM_Success; }

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
    GMTaskPrinter* printer = [[GMTaskPrinter alloc] initWithTask:self];
    return printer.description;
}

@end
