//
// nod - Copyright 2012 Three Rings Design

@class BehaviorTask;

@interface BehaviorTaskPrinter : NSObject {
@protected
    BehaviorTask* _root;
}

- (id)initWithTask:(BehaviorTask*)task;
- (NSString*)description;

@end
