//
//  ThreadSecurityTest.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/8.
//

#import "ThreadSecurityTest.h"

@implementation ThreadSecurityTest

- (instancetype)init{
    
    self =[super init];
    if (self) {
        
        self.ticketCount = 20;
        self.moneyNumber = 300;
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
            
            [self __buyTicket];
        }
    });
    
}
- (void)moneyTest{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        for (int i =0; i<10; i++) {
            
            [self __saveMoney];
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        for (int i =0; i<10; i++) {
            
            [self __getMoney];
        }
    });
}

- (void)__buyTicket{
    
    sleep(1);
    
    self.ticketCount --;
    
    NSLog(@"还剩下%d张票  thread=%@",self.ticketCount,[NSThread currentThread]);
}
- (void)__saveMoney{
    
    sleep(1);
    self.moneyNumber+=50;
    NSLog(@"存50钱还剩下%f钱  thread=%@",self.moneyNumber,[NSThread currentThread]);
}
- (void)__getMoney{
    
    sleep(1);
    self.moneyNumber-=40;
    NSLog(@"取40钱还剩下%f钱 thread=%@",self.moneyNumber,[NSThread currentThread]);
}
@end
