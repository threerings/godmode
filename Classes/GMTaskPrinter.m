//
// godmode - Copyright 2012 Three Rings Design

#import "GMTaskPrinter.h"
#import "GMTask+Protected.h"
#import "GMTask.h"
#import "GMTaskContainer.h"

@implementation GMTaskPrinter

- (id)initWithTask:(GMTask*)task {
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

- (void)visit:(GMTask*)task str:(NSMutableString*)str depth:(int)depth {
    if (depth > 0) {
        [str appendString:@"\n"];
        for (int ii = 0; ii < depth; ++ii) {
            [str appendString:@"-"];
        }
    }
    [str appendFormat:@"[%@]: %@", task.description, task.statusString];

    if ([task conformsToProtocol:@protocol(GMTaskContainer)]) {
        GMTask<GMTaskContainer>* btc = (GMTask<GMTaskContainer>*)task;
        for (GMTask* child in btc.children) {
            [self visit:child str:str depth:depth + 1];
        }
    }
}

@end
