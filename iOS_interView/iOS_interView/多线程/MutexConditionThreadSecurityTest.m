//
//  MutexConditionThreadSecurityTest.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/10.
//

#import "MutexConditionThreadSecurityTest.h"
#import <pthread.h>
@interface MutexConditionThreadSecurityTest ()

@property (assign, nonatomic)pthread_mutex_t mutex;
@property (assign,nonatomic)pthread_cond_t ticketLock;
@end

@implementation MutexConditionThreadSecurityTest

- (instancetype)init{
    
    self =[super init];
    if (self) {
        
        self.ticketCount = 0;
        pthread_mutex_init(&_mutex, NULL);
        pthread_cond_init(&_ticketLock, NULL);

    }
    return self;
}
- (void)ticketTest{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        for (int i =0; i<10; i++) {
            
            [self __buyTicket];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        for (int i =0; i<10; i++) {
            
            [self __returnTicket];
        }
    });
    
}

- (void)__buyTicket{
    
    if (!self.ticketCount) { //没有余票时候 进来等着退票 等待的时候 会把这个锁打开
        
        pthread_cond_wait(&_ticketLock, &_mutex);
    }
    
    NSLog(@"票又开始卖了");
}

- (void)__returnTicket{
    
    self.ticketCount++;
    
    NSLog(@"有人退票");
    /**-----激活等待该条件的线程-----*/
    pthread_cond_signal(&_ticketLock);
    /**-----等待激活所有该条件的线程-----*/
//    pthread_cond_broadcast(&_ticketLock)
}



- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_ticketLock);
}
@end
