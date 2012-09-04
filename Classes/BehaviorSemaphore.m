//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorSemaphore.h"

@implementation BehaviorSemaphore

@synthesize name = _name;

- (id)initWithName:(NSString*)name maxUsers:(int)maxUsers {
    if ((self = [super init])) {
        _name = name;
        _maxUsers = maxUsers;
    }
    return self;
}

- (BOOL)isAcquired {
    return _refCount > 0;
}

- (BOOL)acquire {
    if (_refCount < _maxUsers) {
        ++_refCount;
        return YES;
    }
    return NO;
}

- (void)relinquish {
    NSAssert(_refCount > 0, @"refCount is 0: %@", self);
    --_refCount;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"[name=%@ refCount=%d]", _name, _refCount];
}

@end
