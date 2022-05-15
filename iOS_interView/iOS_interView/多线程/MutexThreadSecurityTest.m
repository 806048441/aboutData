//
//  MutexThreadSecurityTest.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/8.
//

#import "MutexThreadSecurityTest.h"
#import <pthread.h>
@interface MutexThreadSecurityTest ()

@property (assign,nonatomic)pthread_mutex_t ticketLock;
@property (assign,nonatomic)pthread_mutex_t moneyLock;
@end

@implementation MutexThreadSecurityTest

- (instancetype)init{
    
    self =[super init];
    if (self) {
        
        
        pthread_mutex_init(&_ticketLock, NULL);
        
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
        
        //递归锁
//        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);

        pthread_mutex_init(&_moneyLock, &attr);
        pthread_mutexattr_destroy(&attr);
    }
    return self;
}
- (void)__buyTicket{
    
    pthread_mutex_lock(&_ticketLock);
    
    [super __buyTicket];
    
    pthread_mutex_unlock(&_ticketLock);
}

- (void)__saveMoney{
    
    pthread_mutex_lock(&_moneyLock);
    
    [super __saveMoney];
    
    pthread_mutex_unlock(&_moneyLock);
}

- (void)__getMoney{
    
    pthread_mutex_lock(&_moneyLock);
    
    [super __getMoney];
    
    pthread_mutex_unlock(&_moneyLock);
}


- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
    
    pthread_mutex_destroy(&_ticketLock);
    pthread_mutex_destroy(&_moneyLock);
}
@end
