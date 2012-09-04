//
// nod - Copyright 2012 Three Rings Design

@interface BehaviorSemaphore : NSObject {
@protected
    NSString* _name;
    int _maxUsers;
    int _refCount;
}

@property (nonatomic,readonly) NSString* name;
@property (nonatomic,readonly) BOOL isAcquired; // YES if at least one client holds the semaphore

- (id)initWithName:(NSString*)name maxUsers:(int)maxUsers;

- (BOOL)acquire; // YES if successfully acquired
- (void)relinquish;

@end
