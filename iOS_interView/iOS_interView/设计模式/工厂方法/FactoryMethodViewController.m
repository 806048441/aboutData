//
//  FactoryMethodViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/2/23.
//

#import "FactoryMethodViewController.h"
#import "CalculateOperation.h"
#import "AddFactory.h"
@interface FactoryMethodViewController ()

@end

@implementation FactoryMethodViewController

- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor =[UIColor blueColor];
    
    [self factoryMethod1];
}

//工厂方法模式(Factory Method Pattern)又称为工厂模式，工厂父类负责定义创建产品对象的公共接口，而工厂子类则负责生成具体的产品对象，即通过不同的工厂子类来创建不同的产品对象。
//工厂方法模式的适用场景与简单工厂类似，都是创建数据和行为比较类似的对象。但是和简单工厂不同的是：在工厂方法模式中，因为创建对象的责任移交给了抽象工厂的子类，因此客户端需要知道其所需产品所对应的工厂子类，而不是简单工厂中的参数
//适用情况：一个类无法预期需要生成哪个类的对象，让其子类来指定生成对象。使得一个类的实例化延迟到子类


- (void)factoryMethod1{
   
//    大部分这种情况 工厂类操作类是一个类 这样
    OperationFactory *factory = [[AddFactory alloc]init];
    CalculateOperation *operation = [factory creatOperation];
    operation.number1 = 1;
    operation.number2 = 2;
    NSLog(@"%f",operation.calculateResult);
}
@end
