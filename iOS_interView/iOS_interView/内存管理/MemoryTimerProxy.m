//
//  MemoryTimerProxy.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/10.
//

#import "MemoryTimerProxy.h"

@implementation MemoryTimerProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    
    [invocation invokeWithTarget:self.target];
}
@end
