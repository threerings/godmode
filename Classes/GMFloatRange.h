//
// godmode - Copyright 2012 Three Rings Design

@class GMRandoms;
@protocol GMRng;

@interface GMFloatRange : NSObject {
@protected
    float _min;
    float _max;
    GMRandoms* _rands;
}

@property (nonatomic,assign) float min;
@property (nonatomic,assign) float max;

- (id)initWithMin:(float)min max:(float)max rng:(id<GMRng>)rng;

/// Returns a float between [min, max)
- (float)next;

@end
