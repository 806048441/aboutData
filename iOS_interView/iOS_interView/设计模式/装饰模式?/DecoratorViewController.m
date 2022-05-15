//
//  DecoratorViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/3.
//

#import "DecoratorViewController.h"
#import "DecoratorPerson.h"
#import "DecoratorA.h"
#import "DecoratorB.h"
@interface DecoratorViewController ()

@end

@implementation DecoratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =@"装饰模式";
    
    DecoratorPerson *xiaoM = [[DecoratorPerson alloc]initWithName:@"xiaoM"];
    
    DecoratorA *a= [[DecoratorA alloc]initWithPerson:xiaoM];
    
    DecoratorB *b= [[DecoratorB alloc]initWithPerson:xiaoM];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
