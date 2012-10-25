//
// godmode - Copyright 2012 Three Rings Design

#import "GMBlackboard.h"

static id GMNSNullToNil (id obj) { return (obj == [NSNull null] ? nil : obj); }
static id GMNilToNSNull (id obj) { return (obj == nil ? [NSNull null] : obj); }

@interface GMBoxedWeakRef : NSObject <NSCopying> {
@protected
    __weak id _value;
}
@property (weak) id value;
- (id)initWithValue:(id)val;
@end

@implementation GMBlackboard

- (id)init {
    if ((self = [super init])) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)containsKey:(NSString*)key {
    return [_dict objectForKey:key] != nil;
}

- (void)removeKey:(NSString*)key {
    [_dict removeObjectForKey:key];
}

- (id)objectForKey:(NSString*)key {
    id obj = GMNSNullToNil([_dict objectForKey:key]);
    return ([obj isKindOfClass:[GMBoxedWeakRef class]] ? ((GMBoxedWeakRef*)obj).value : obj);
}

- (BOOL)boolForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    return ([obj isKindOfClass:[NSNumber class]] ? ((NSNumber*)obj).boolValue : NO);
}

- (int)intForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    return ([obj isKindOfClass:[NSNumber class]] ? ((NSNumber*)obj).intValue : 0);
}

- (float)floatForKey:(NSString*)key {
    id obj = [self objectForKey:key];
    return ([obj isKindOfClass:[NSNumber class]] ? ((NSNumber*)obj).floatValue : 0);
}

- (void)setObject:(id)value forKey:(NSString*)key {
    [_dict setObject:GMNilToNSNull(value) forKey:key];
}

- (void)setWeakObject:(id)value forKey:(NSString*)key {
    [self setObject:[[GMBoxedWeakRef alloc] initWithValue:value] forKey:key];
}

- (void)setBool:(BOOL)value forKey:(NSString*)key {
    [self setObject:@(value) forKey:key];
}

- (void)setInt:(int)value forKey:(NSString*)key {
    [self setObject:@(value) forKey:key];
}

- (void)setFloat:(float)value forKey:(NSString*)key {
    [self setObject:@(value) forKey:key];
}

@end


@implementation GMBoxedWeakRef

@synthesize value = _value;

- (id)initWithValue:(id)val {
    if ((self = [super init])) {
        _value = val;
    }
    return self;
}

- (id)copyWithZone:(NSZone*)zone {
    return [[GMBoxedWeakRef allocWithZone:zone] initWithValue:_value];
}

- (NSUInteger)hash {
    return (NSUInteger)_value;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if (other == nil || ![other isKindOfClass:[self class]]) {
        return NO;
    } else {
        return ((GMBoxedWeakRef*)other)->_value == _value;
    }
}

@end