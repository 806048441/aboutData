//
//  StrategyTotalMoneyB.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/1.
//

#import "StrategyTotalMoneyB.h"

@interface StrategyTotalMoneyB (){
    
@private float _totalMoney,_returnMoney;
}
@end

@implementation StrategyTotalMoneyB

+ (StrategyTotalMoneyB*)returnStrategy:(float)totalMoney returnMoney:(float)returnMoney{
    
    StrategyTotalMoneyB *strategyB = [[StrategyTotalMoneyB alloc]init];
    strategyB->_totalMoney=totalMoney;
    strategyB->_returnMoney=returnMoney;
    return strategyB;
}

- (float)calculateMoney{
    
    if (_totalMoney<=self.price) {
        
        return self.price-_returnMoney;
    }
    return self.price;
}
@end
