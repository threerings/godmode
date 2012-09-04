//
// nod - Copyright 2012 Three Rings Design

@interface GMBlackboard : NSObject {
@protected
    NSMutableDictionary* _dict;
}

- (BOOL)containsKey:(NSString*)key;
- (void)removeKey:(NSString*)key;

- (id)objectForKey:(NSString*)key;
- (BOOL)boolForKey:(NSString*)key;
- (int)intForKey:(NSString*)key;
- (float)floatForKey:(NSString*)key;

- (void)setObject:(id)value forKey:(NSString*)key;
- (void)setWeakObject:(id)value forKey:(NSString*)key;
- (void)setBool:(BOOL)value forKey:(NSString*)key;
- (void)setInt:(int)value forKey:(NSString*)key;
- (void)setFloat:(float)value forKey:(NSString*)key;

@end
