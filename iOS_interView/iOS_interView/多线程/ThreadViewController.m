//
//  ThreadViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/8.
//

#import "ThreadViewController.h"
#import "ThreadSecurityTest.h"
#import "OSSpinLockThreadSecurityTest.h"
#import "OSUnFairThreadSecurityTest.h"
#import "MutexThreadSecurityTest.h"
#import "MutexConditionThreadSecurityTest.h"
@interface ThreadViewController ()

@end

@implementation ThreadViewController

- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self interview1];
}

- (void)interview1{//用信号量 多个任务执行完 再执行另一个任务
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1");
        dispatch_semaphore_signal(sem);
    });
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:3];
        NSLog(@"2");
        dispatch_semaphore_signal(sem);
    });
//
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"3");
    
}

/**-----多线程方案
 提高效率 但是会有资源抢夺的问题
 1 pthread  C语言Api 可跨平台使用 需要自己管理线程  几乎不用
 2 NSThread OCApi 需要自己管理线程 不常用
 3 GCD C语言Api 不需要自己管理线程 经常使用
 4 NSOperation OCApi封装了GCD 不需要自己管理线程 经常使用-----*/

- (void)taskStart{
    
    NSLog(@"---start---");
}

- (void)taskEnd{
    
    NSLog(@"---end---");
}

- (void)task1{
    
    NSLog(@"%@---%s",[NSThread currentThread],__FUNCTION__);
}

- (void)task2{
    
    NSLog(@"%@---%s",[NSThread currentThread],__FUNCTION__);
}
/**-----GCD队列类型
 1 串行队列
 2 并行队列
 3 主队列 也是一个串行队列
 4 global队列 也是一个并行队列-----*/

/**-----串行队列 同步执行任务 不开启新线程 任务一个接着一个执行-----*/
- (void)syncSerial{
    
    [self taskStart];
    
    dispatch_queue_t queue = dispatch_queue_create("SERIAL", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task2];
        }
    });
    
    dispatch_sync(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task1];
        }
    });
    
    [self taskEnd];
    
    /**-----打印顺序 start task2 task1 end 因为是同步 所以到加队列的任务 肯定立马执行-----*/

}

/**-----串行队列 异步执行任务 开启新线程 任务一个接着一个执行 串行执行任务-----*/
- (void)asyncSerial{
    
    [self taskStart];
    
    dispatch_queue_t queue = dispatch_queue_create("SERIAL", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task2];
        }
    });
    
    dispatch_async(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task1];
        }
    });
    
    [self taskEnd];
    
    /**-----打印顺序 start end task2 task1  end先执行是因为 开启线程需要时间 异步情况下 任务之间互相 不影响 所以task2 task1 会后执行-----*/
}

/**-----并行队列 同步执行任务 不开启新线程 任务一个接着一个执行-----*/
- (void)syncConcurrent{
    
    [self taskStart];
    
    dispatch_queue_t queue = dispatch_queue_create("CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task2];
        }
    });
    
    dispatch_sync(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task1];
        }
    });
    
    [self taskEnd];
    
    /**-----打印顺序 start task2 task1 end 因为是同步 所以到加队列的任务 肯定立马执行-----*/
}

/**-----并行队列 异步执行任务 开启新线程 任务并发执行 可能无序-----*/
- (void)asyncConcurrent{
    
    [self taskStart];
    
    dispatch_queue_t queue = dispatch_queue_create("CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task2];
        }
    });
    
    dispatch_async(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task1];
        }
    });
    
    [self taskEnd];
    
    /**-----打印顺序 start end task2 task1  end先执行是因为 开启线程需要时间 异步情况下 任务之间互相 不影响 所以task2 task1 会后执行-----*/
}

/**-----主队列 同步执行任务 死锁 -----*/
- (void)syncMain{
    
    [self taskStart];

    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task2];
        }
    });
    
    dispatch_sync(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task1];
        }
    });
    
    [self taskEnd];
    
    /**-----打印顺序 start 然后崩溃-----*/
}

/**-----主队列 异步步执行任务 一个一个执行 -----*/
- (void)asyncMain{
    
    [self taskStart];

    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task2];
        }
    });
    
    dispatch_async(queue, ^{
       
        for (int i =0; i<10; i++) {
            
            [self task1];
        }
    });
    
    [self taskEnd];
    
    /**-----打印顺序 start end task2 task1 end先执行是因为 end任务是属于asyncMain该方法 所以主队列必须先把asyncMain这个任务执行完 或者说主线程中的已经有的任务 执行完 才能执行添加进去的 task2 task1 -----*/
}

/**-----线程安全问题 多个线程同时访问一个方法 改变数据 资源抢夺 造成数据混乱-----*/
- (void)threadSecurityTest1{
    
    ThreadSecurityTest *test =[[ThreadSecurityTest alloc]init];
    [test ticketTest];
    /**-----这里内部实现 是本来20张票 卖了20张 应该剩0张 但是打印出来却不是-----*/
}

/**-----自旋锁 当某方法已经上锁时 进来会处于忙等状态 相当于一个while循环 一直占用cpu资源 一直等这个锁解锁后 立马进去
 目前已经不再安全，可能会出现优先级反转问题
 如果等待锁的线程优先级较高，它会一直占用着CPU资源，优先级低的线程就无法释放锁
-----*/
- (void)OSSpinLockThreadSecurityTest{
 
    ThreadSecurityTest *test =[[OSSpinLockThreadSecurityTest alloc]init];
    [test ticketTest];
    [test moneyTest];
}

/**-----iOS10开始支持 用来取代OSSpinLock 底层调用来看 在等待时候会进入休眠 不会占用cpu资源-----*/
- (void)OSUnFairThreadSecurityTest{
    
    ThreadSecurityTest *test =[[OSUnFairThreadSecurityTest alloc]init];
    [test ticketTest];
    [test moneyTest];
}

/**-----phtread_mutex_lock 锁 可以设置锁的类型
#define PTHREAD_MUTEX_NORMAL        0 普通锁
#define PTHREAD_MUTEX_ERRORCHECK    1
#define PTHREAD_MUTEX_RECURSIVE        2 递归锁 这种允许同一个线程 多次给某方法加锁
#define PTHREAD_MUTEX_DEFAULT        PTHREAD_MUTEX_NORMAL
-----*/
- (void)MutexThreadSecurityTest{
    
    ThreadSecurityTest *test =[[MutexThreadSecurityTest alloc]init];
    [test ticketTest];
    [test moneyTest];
}

/**-----条件锁 满足某条件时 加锁 解锁-----*/
- (void)MutexConditionThreadSecurityTest{
    
    ThreadSecurityTest *test =[[MutexConditionThreadSecurityTest alloc]init];
    [test ticketTest];
}
@end
