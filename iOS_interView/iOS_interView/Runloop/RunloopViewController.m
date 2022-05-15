//
//  RunloopViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/5.
//

#import "RunloopViewController.h"
#import "RunloopAliveThread.h"
@interface RunloopViewController ()

@property (strong,nonatomic)RunloopAliveThread *thread;
@end

@implementation RunloopViewController
- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
    [self.thread exit];
}

- (NSString*)getString{
    
    return (__bridge  NSString*)CFStringCreateWithCString(nil, "h", NSUTF8StringEncoding);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
//    [self getString];
//
//    float a = 1;
//    float b = MIN(a++, 1.5);
//
//    NSLog(@"%f  %f ",a,b);
//
    dispatch_queue_t queue = dispatch_queue_create("12", DISPATCH_QUEUE_SERIAL);

    dispatch_async(queue, ^{

        NSLog(@"1");
    });

    dispatch_sync(queue, ^{

        NSLog(@"2");
    });

    dispatch_async(queue, ^{

        NSLog(@"3");
        dispatch_sync(queue, ^{

            NSLog(@"4");
        });

    });
    
    [self interview_100];
}

- (RunloopAliveThread *)thread{
    
    if (!_thread) {
        
        _thread =[[RunloopAliveThread alloc]init];
        [_thread start];
    }
    return _thread;
}

/**-----runloop事件循环 通过用户态和内核态的切换 完成事件循环 该休息的时候休眠 该做事的时候醒来做事 两套API 一套是OC NSRunloop 一套是C CFRunloop
 runloop和线程是一对一的 储存方式相当于一个字典 线程是key runloop是value 源码都是通过线程获取runloop的
 线程默认runloop是没有开启的 runloop在第一次获取的时候创建 从源码中可以看出来 没有runloop线程做完事情会立马退出 runloop可以在没事可做的时候休眠 并不占用资源
 runloop作用 保证线程不退出 处理事件 触摸事件、线程通信、timer事件。还有一点就是休眠的时候并不占用资源
 -----*/

/**-----runloop底层的数据结构-----*/
//struct __CFRunLoop {
//    CFRuntimeBase _base;
//    pthread_mutex_t _lock;            /* locked for accessing mode list */
//    __CFPort _wakeUpPort;            // used for CFRunLoopWakeUp
//    Boolean _unused;
//    volatile _per_run_data *_perRunData;              // reset for runs of the run loop
//    pthread_t _pthread;//对应的线程
//    uint32_t _winthread;
//    CFMutableSetRef _commonModes;//commonMode
//    CFMutableSetRef _commonModeItems;//commonMode中的所有modeItem
//    CFRunLoopModeRef _currentMode;//当前mode
//    CFMutableSetRef _modes;//所有mode
//    struct _block_item *_blocks_head;
//    struct _block_item *_blocks_tail;
//    CFAbsoluteTime _runTime;
//    CFAbsoluteTime _sleepTime;
//    CFTypeRef _counterpart;
//};

//struct __CFRunLoopMode {
//    CFRuntimeBase _base;
//    pthread_mutex_t _lock;    /* must have the run loop locked before locking this */
//    CFStringRef _name;
//    Boolean _stopped;
//    char _padding[3];
//    CFMutableSetRef _sources0;
//    CFMutableSetRef _sources1;
//    CFMutableArrayRef _observers;
//    CFMutableArrayRef _timers;
//    CFMutableDictionaryRef _portToV1SourceMap;
//    __CFPortSet _portSet;
//    CFIndex _observerMask;
//#if USE_DISPATCH_SOURCE_FOR_TIMERS
//    dispatch_source_t _timerSource;
//    dispatch_queue_t _queue;
//    Boolean _timerFired; // set to true by the source when a timer has fired
//    Boolean _dispatchTimerArmed;
//#endif
//#if USE_MK_TIMER_TOO
//    mach_port_t _timerPort;
//    Boolean _mkTimerArmed;
//#endif
//#if DEPLOYMENT_TARGET_WINDOWS
//    DWORD _msgQMask;
//    void (*_msgPump)(void);
//#endif
//    uint64_t _timerSoftDeadline; /* TSR */
//    uint64_t _timerHardDeadline; /* TSR */
//};

/**-----runloop中 各个mode之间是分开互不影响的 当一个mode切换到另一个mode时 runloop必须退出当前mode 进入另一个mode runloop的mode中 包括四种item _sources0 _sources1 _observers _timers-----*/
- (void)getRunloop{
    
    NSLog(@"%p %p %p %p",[NSRunLoop mainRunLoop],[NSRunLoop currentRunLoop],CFRunLoopGetMain(),CFRunLoopGetCurrent());    
}

- (void)threadAlive{
    
    __weak typeof(self) weakSelf = self;
    [self.thread excuteTask:^{
            
        [weakSelf threadMethod];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    __weak typeof(self) weakSelf = self;
    [self.thread excuteTask:^{
            
        [weakSelf threadMethod];
    }];
}

- (void)threadMethod{
    
    NSLog(@"%s,%@",__FUNCTION__,[NSThread currentThread]);
}


- (void)interview_100{
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        NSLog(@"1");
//
//        [self performSelector:@selector(interview_100Test) withObject:nil afterDelay:0];
//        NSLog(@"3");
//        [[NSRunLoop currentRunLoop] run];
//    });
    
    NSThread *thread =[[NSThread alloc]initWithBlock:^{
        
//        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
    
    [self performSelector:@selector(interview_100Test) onThread:thread withObject:nil waitUntilDone:NO];
}

- (void)interview_100Test{
    
    NSLog(@"2");
}
@end
