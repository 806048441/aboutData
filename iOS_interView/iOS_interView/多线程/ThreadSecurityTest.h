//
//  ThreadSecurityTest.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/8.
//

#import <Foundation/Foundation.h>

@interface ThreadSecurityTest : NSObject

@property (assign,nonatomic)int ticketCount;
@property (assign,nonatomic)float moneyNumber;

- (void)ticketTest;
- (void)moneyTest;
- (void)__buyTicket;
- (void)__saveMoney;
- (void)__getMoney;
@end

