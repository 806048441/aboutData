//
//  RunloopAliveThread.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/12.
//

#import "RunloopAliveThread.h"
@interface RunloopAliveThread ()

@property (strong,nonatomic)NSThread *thread;
@end

@implementation RunloopAliveThread
- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
}

- (instancetype)init{
    
    self =[super init];
    if (self) {
        
        self.thread =[[NSThread alloc]initWithBlock:^{
            
            //这种写法不能停止
//            [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
//            [[NSRunLoop currentRunLoop] run];
            
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            // 销毁source
            CFRelease(source);
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        }];
        
    }
    return self;
}

- (void)start{
    
    [self.thread start];
}
- (void)exit{
    
    if (!self.thread) {
        
        return;
    }
    [self performSelector:@selector(__exit) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)excuteTask:(void(^)(void))task{
    
    if (!task || !self.thread) {
        
        return;
    }
    [self performSelector:@selector(__task:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)__exit{
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__task:(void(^)(void))task{
    
    task();
}
@end
