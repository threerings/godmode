//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorPredicate.h"
#import "BehaviorTaskContainer.h"
#import "BehaviorTask+Protected.h"

@implementation NotBehaviorPredicate
- (id)initWithName:(NSString*)name pred:(BehaviorPredicate*)pred {
    if ((self = [super initWithName:name])) {
        _pred = pred;
    }
    return self;
}

- (BOOL)evaluate { return !_pred.evaluate; }
- (id<NSFastEnumeration>)children { return [OOOCollections singleton:_pred]; }
@end

@implementation AndBehaviorPredicate
- (id)initWithName:(NSString*)name preds:(NSArray*)preds {
    if ((self = [super initWithName:name])) {
        _preds = preds;
    }
    return self;
}
- (BOOL)evaluate {
    for (BehaviorPredicate* pred in _preds) {
        if (!pred.evaluate) {
            return NO;
        }
    }
    return YES;
}
- (id<NSFastEnumeration>)children { return _preds; }
@end

@implementation OrBehaviorPredicate
- (id)initWithName:(NSString*)name preds:(NSArray*)preds {
    if ((self = [super initWithName:name])) {
        _preds = preds;
    }
    return self;
}
- (BOOL)evaluate {
    for (BehaviorPredicate* pred in _preds) {
        if (pred.evaluate) {
            return YES;
        }
    }
    return NO;
}
- (id<NSFastEnumeration>)children { return _preds; }
@end

typedef BOOL (^BoolBlock)();
@implementation BlockBehaviorPredicate
- (id)initWithName:(NSString*)name block:(BOOL(^)())pred {
    if ((self = [super initWithName:name])) {
        _block = [pred copy];
    }
    return self;
}
- (BOOL)evaluate { return _block(); }
@end

@implementation BehaviorPredicate

- (BOOL)evaluate {
    OOO_IS_ABSTRACT();
    return NO;
}

- (BehaviorStatus)update:(float)dt {
    return ([self evaluate] ? BehaviorSuccess : BehaviorFail);
}

@end
