//
// godmode - Copyright 2012 Three Rings Design

#import "GMFlagSetPredicate.h"

@implementation GMFlagSetPredicate

- (id)initWithName:(NSString*)name flags:(OOOFlags*)flags flag:(int)flag {
    if ((self = [super initWithName:name])) {
        _flags = flags;
        _flag = flag;
    }
    return self;
}

- (BOOL)evaluate {
    return [_flags isSet:_flag];
}

@end
