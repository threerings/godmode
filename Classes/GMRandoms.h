//
// godmode - Copyright 2012 Three Rings Design

@protocol GMRng <NSObject>
/// Return an unsigned long in the range [0, (2^32)-1)
- (unsigned long)genLong;
@end

@interface GMRandoms : NSObject {
@protected
    id<GMRng> _rng;
}

+ (GMRandoms*)withRng:(id<GMRng>)rng;

- (id)initWithRng:(id<GMRng>)rng;

- (int)getInt:(int)high;
- (int)getIntLow:(int)low high:(int)high;
- (unsigned int)getUint:(unsigned int)high;
- (unsigned int)getUintLow:(unsigned int)low high:(unsigned int)high;
- (float)getFloat:(float)high;
- (float)getFloatLow:(float)low high:(float)high;
- (BOOL)getBool;
- (BOOL)getChance:(int)n;
- (BOOL)getProbability:(float)p;
- (id)getObject:(NSArray*)array;
- (int)getDiceRoll:(int)numDice d:(int)numFaces;

@end
