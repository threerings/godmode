//
// godmode - Copyright 2012 Three Rings Design

#import "GMRandoms.h"

// 1/(2^32)
static const double MAXLONG_DIVISOR = 1.0/4294967296.0;

@implementation GMRandoms

+ (GMRandoms*)withRng:(id<GMRng>)rng {
    return [[GMRandoms alloc] initWithRng:rng];
}

- (id)initWithRng:(id<GMRng>)rng {
    if ((self = [super init])) {
        _rng = rng;
    }
    return self;
}

- (int)getInt:(int)high {
    return (int) ([_rng genLong] % (unsigned long) high);
}

- (int)getIntLow:(int)low high:(int)high {
    return low + [self getInt:high - low];
}

- (unsigned int)getUint:(unsigned int)high {
    return (unsigned int) ([_rng genLong] % (unsigned long) high);
}

- (unsigned int)getUintLow:(unsigned int)low high:(unsigned int)high {
    return low + [self getUint:high - low];
}

- (float)getFloat:(float)high {
    return [self nextDouble] * high;
}

- (float)getFloatLow:(float)low high:(float)high {
    return low + ([self nextDouble] * (high - low));
}

- (BOOL)getBool {
    return [_rng genLong] % 2 != 0;
}

- (BOOL)getChance:(int)n {
    return (0 == [self getInt:n]);
}

- (BOOL)getProbability:(float)p {
    return [self getFloat:1] < p;
}

- (id)getObject:(NSArray*)array {
    return (array.count > 0 ? array[[self getInt:array.count]] : nil);
}

- (int)getDiceRoll:(int)numDice d:(int)numFaces {
    int sum = 0;
    for (int ii = 0; ii < numDice; ++ii) {
        sum += [self getIntLow:1 high:numFaces + 1];
    }
    return sum;
}

- (double)nextDouble {
    return [_rng genLong] * MAXLONG_DIVISOR;
}

@end