//
//  SimpleFactoryViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/2/23.
//

#import "SimpleFactoryViewController.h"
#import "SimpleFactoryCell.h"

#import "SimpleOperatonFactory.h"
#import "SimpleCalculateOperation.h"
@interface SimpleFactoryViewController ()


@end

@implementation SimpleFactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.title =@"简单工厂设计模式";
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self simpleFactory2];
}

//简单工厂：简单工厂不是一个模式，而是一种编程习惯，提供一个创建对象实例的功能，而无需关心具体实现。被创建的类型可以使用接口、抽象类、具体类。
//简单工厂模式(Simple Factory Pattern)：专门定义一个类（工厂类）来负责创建其他类的实例。可以根据创建方法的参数来返回不同类的实例，被创建的实例通常都具有共同的父类。
//总结来说，其实就是把一大堆的if-else判断由业务层，放到了工厂类里面 并没有真正改变什么逻辑

//优点
//客户端只需要给工厂类传入一个正确的（约定好的）参数，就可以获取你所需要的对象，而不需要知道其创建细节，一定程度上减少系统的耦合
//缺点
//如果我们要是在添加Cell，那么我们就需要修改FactoryCell的方法，违反了开闭原则。
//简单来说就是违反了依赖倒置原则，让高层组件client依赖于底层组件。违反这个原则的后果就是一旦底层组件改动，那么高层组件也就必须改动，违反了开闭原则。
//简单工厂的本质：选择实现
//何时使用简单工厂
//1、想完全封装隔离具体实现 让外部只能通过抽象类或者接口来操作，上面的例子中，就是只能操作FactoryCell，而不能操作具体类。此时可以使用简单工厂，让客户端通过简单工厂来选择创建具体的类，不需要创建的具体过程。
//2、想把创建对象的职责集中管理起来 一个简单工厂可以创建许多相关或者不相关的对象，所以可以把对象的创建集中到简单工厂来集中管理。
- (void)simpleFactory1{
    
    NSArray *dataSource = @[
        @{@"type":@"1",@"data":@"😄"},
        @{@"type":@"2",@"data":@"qrcode"}];
    
    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SimpleFactoryCell *cell = [[SimpleFactoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SimpleFactoryCell" type:[dataSource[idx][@"type"] integerValue]];
        cell.data = dataSource[idx][@"data"];
        cell.frame =CGRectMake(0, 210*(idx+1), 200, 200);
        cell.contentView.backgroundColor =[UIColor redColor];
        [self.view addSubview:cell];
    }];
}

- (void)simpleFactory2{
    
    SimpleCalculateOperation *addOpertaion = [SimpleOperatonFactory createOperation:0];
    addOpertaion.number1 = 1;
    addOpertaion.number2 = 2;
    NSLog(@"%f>>>>",[addOpertaion calculateResult]);
}


@end
