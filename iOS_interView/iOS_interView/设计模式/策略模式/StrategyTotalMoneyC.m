//
//  StrategyTotalMoneyC.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/1.
//

#import "StrategyTotalMoneyC.h"

@interface StrategyTotalMoneyC (){
    
@private float _rate;
}
@end

@implementation StrategyTotalMoneyC

+ (StrategyTotalMoneyC*)rebateStrategy:(float)rate{
    
    StrategyTotalMoneyC *strategyC =[StrategyTotalMoneyC new];
    strategyC->_rate = rate;
    return strategyC;
}

- (float)calculateMoney{
    
    return self.price*self->_rate;
}
@end
