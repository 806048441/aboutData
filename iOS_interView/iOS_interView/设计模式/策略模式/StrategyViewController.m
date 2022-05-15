//
//  StrategyViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/1.
//

#import "StrategyViewController.h"
#import "StrategyTotalMoneyA.h"
#import "StrategyTotalMoneyB.h"
#import "StrategyTotalMoneyC.h"
@interface StrategyViewController ()

@end

@implementation StrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"策略设计模式";
    self.view.backgroundColor =[UIColor whiteColor];
    [self strategy01];
}

//策略模式：它定义了算法家族，分别分装起来，让他们之间可以互相替换，此模式让算法的变化，不会影响到使用算法的客户；也就是一种定义一系列算法的方法，所有这些算法都是完成相同工作的，只是实现不同，他可以以相同的方式调用所有的算法，减少各种算法类与使用算法类之间的耦合
- (void)strategy01{
    
    NSArray <NSNumber*>*prices = @[@(arc4random()%1000),@(arc4random()%1000),@(arc4random()%1000),@(arc4random()%1000),@(arc4random()%1000)];
    
    StrategyTotalMoneyA *strategyA = [StrategyTotalMoneyA normalStrategy];
    
    StrategyTotalMoneyB *strategyB = [StrategyTotalMoneyB returnStrategy:500 returnMoney:200];

    StrategyTotalMoneyC *strategyC = [StrategyTotalMoneyC rebateStrategy:0.9];
    
    __block float totalMoneyA = 0,totalMoneyB = 0,totalMoneyC = 0;
    [prices enumerateObjectsUsingBlock:^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        strategyA.price = obj.floatValue;
        strategyB.price = obj.floatValue;
        strategyC.price = obj.floatValue;

        totalMoneyA+=strategyA.calculateMoney;
        totalMoneyB+=strategyB.calculateMoney;
        totalMoneyC+=strategyC.calculateMoney;
    }];
    
    NSLog(@"%f  %f  %f",totalMoneyA,totalMoneyB,totalMoneyC);

}

@end
