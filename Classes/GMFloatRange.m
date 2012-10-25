//
// godmode - Copyright 2012 Three Rings Design

#import "GMFloatRange.h"
#import "GMRandoms.h"

@implementation GMFloatRange

@synthesize min = _min;
@synthesize max = _max;

- (id)initWithMin:(float)min max:(float)max rng:(id<GMRng>)rng {
    if ((self = [super init])) {
        _min = min;
        _max = max;
        _rands = [GMRandoms withRng:rng];
    }
    return self;
}

- (float)next {
    return [_rands getFloatLow:_min high:_max];
}

@end
