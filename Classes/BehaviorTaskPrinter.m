//
// nod - Copyright 2012 Three Rings Design

#import "BehaviorTaskPrinter.h"
#import "BehaviorTask+Protected.h"
#import "BehaviorTask.h"
#import "BehaviorTaskContainer.h"

@implementation BehaviorTaskPrinter

- (id)initWithTask:(BehaviorTask*)task {
    if ((self = [super init])) {
        _root = task;
    }
    return self;
}

- (NSString*)description {
    NSMutableString* str = [NSMutableString string];
    [self visit:_root str:str depth:0];
    return str;
}

- (void)visit:(BehaviorTask*)task str:(NSMutableString*)str depth:(int)depth {
    if (depth > 0) {
        [str appendString:@"\n"];
        for (int ii = 0; ii < depth; ++ii) {
            [str appendString:@"-"];
        }
    }
    [str appendFormat:@"[%@]: %@", task.description, task.statusString];

    if ([task conformsToProtocol:@protocol(BehaviorTaskContainer)]) {
        BehaviorTask<BehaviorTaskContainer>* btc = (BehaviorTask<BehaviorTaskContainer>*)task;
        for (BehaviorTask* child in btc.children) {
            [self visit:child str:str depth:depth + 1];
        }
    }
}

@end
