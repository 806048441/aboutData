//
//  StrategyTotalMoneyA.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/1.
//

#import "StrategyTotalMoneyA.h"

@implementation StrategyTotalMoneyA

+ (StrategyTotalMoneyA*)normalStrategy{
    
    return [StrategyTotalMoneyA new];
}
- (float)calculateMoney{
    
    return self.price;
}
@end
