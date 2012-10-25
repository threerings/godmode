//
// godmode - Copyright 2012 Three Rings Design

/// Throws an exception indicating that the current method is abstract
#define GM_IS_ABSTRACT() ({ \
    [NSException raise:NSInternalInconsistencyException \
    format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]; \
    })
