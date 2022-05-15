//
//  OSUnFairThreadSecurityTest.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/8.
//

#import "OSUnFairThreadSecurityTest.h"
#import <os/lock.h>
@interface OSUnFairThreadSecurityTest ()

@property (assign,nonatomic)os_unfair_lock ticketLock;
@property (assign,nonatomic)os_unfair_lock moneyLock;
@end

@implementation OSUnFairThreadSecurityTest

- (instancetype)init{
    
    self =[super init];
    if (self) {
        
        self.ticketLock =OS_UNFAIR_LOCK_INIT;
        self.moneyLock =OS_UNFAIR_LOCK_INIT;
    }
    return self;
}
- (void)__buyTicket{
    
    os_unfair_lock_lock(&_ticketLock);
    
    [super __buyTicket];
    
    os_unfair_lock_unlock(&_ticketLock);
}

- (void)__saveMoney{
    
    os_unfair_lock_lock(&_moneyLock);
    
    [super __saveMoney];
    
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__getMoney{
    
    os_unfair_lock_lock(&_moneyLock);
    
    [super __getMoney];
    
    os_unfair_lock_unlock(&_moneyLock);
    
}
@end
