//
// nod - Copyright 2012 Three Rings Design

#import "GMBlackboard.h"

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
    id obj = OOONSNullToNil([_dict objectForKey:key]);
    return ([obj isKindOfClass:[OOOBoxedWeakRef class]] ? ((OOOBoxedWeakRef*)obj).value : obj);
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
    [_dict setObject:OOONilToNSNull(value) forKey:key];
}

- (void)setWeakObject:(id)value forKey:(NSString*)key {
    [self setObject:[OOOBoxedWeakRef boxedWeakRefWithValue:value] forKey:key];
}

- (void)setBool:(BOOL)value forKey:(NSString*)key {
    [self setObject:[NSNumber numberWithBool:value] forKey:key];
}

- (void)setInt:(int)value forKey:(NSString*)key {
    [self setObject:[NSNumber numberWithInt:value] forKey:key];
}

- (void)setFloat:(float)value forKey:(NSString*)key {
    [self setObject:[NSNumber numberWithFloat:value] forKey:key];
}

@end
