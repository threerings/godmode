//
// nod - Copyright 2012 Three Rings Design

@class GMTask;

@interface GMTaskPrinter : NSObject {
@protected
    GMTask* _root;
}

- (id)initWithTask:(GMTask*)task;
- (NSString*)description;

@end
