//
//  OSSpinLockThreadSecurityTest.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/8.
//

#import "OSSpinLockThreadSecurityTest.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockThreadSecurityTest ()

@property (assign,nonatomic)OSSpinLock ticketLock;
@property (assign,nonatomic)OSSpinLock moneyLock;
@end

@implementation OSSpinLockThreadSecurityTest

- (instancetype)init{
    
    self =[super init];
    if (self) {
        
        self.ticketLock =OS_SPINLOCK_INIT;
        self.moneyLock =OS_SPINLOCK_INIT;
    }
    return self;
}
- (void)__buyTicket{
    
    OSSpinLockLock(&_ticketLock);
    
    [super __buyTicket];
    
    OSSpinLockUnlock(&_ticketLock);
}

- (void)__saveMoney{
    
    OSSpinLockLock(&_moneyLock);
    
    [super __saveMoney];
    
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__getMoney{
    
    OSSpinLockLock(&_moneyLock);
    
    [super __getMoney];
    
    OSSpinLockUnlock(&_moneyLock);
    
}
@end
