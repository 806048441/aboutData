//
//  FishhookViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/10.
//

#import "FishhookViewController.h"
#include "fishhook.h"
#import "MyDynamicPerson.h"
#import <objc/message.h>
@interface FishhookViewController ()

@end

@implementation FishhookViewController

static void(*dynamicFuncPtr)(NSString*str);

static void(*selfFuncPrt)(int num);

void testDynamicNewFunc(NSString *str){
    
    NSLog(@"str----hook到了");
}

void testSelfOldFunc(int num){
    
    NSLog(@"%d",num);
}

void testSelfNewFunc(int num){
    
    NSLog(@"%d",num*10);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self test1];
}

- (void)test1{
    
    dynamicLog(@"头一次输入");
    struct rebinding func;
    func.name = "dynamicLog";
    func.replacement = (void*)testDynamicNewFunc;
    func.replaced = (void**)&dynamicFuncPtr;
    struct rebinding rebs[1] = {func};
    rebind_symbols(rebs, 1);
    dynamicLog(@"laile");
    
    void(*testDynamicFuncPtr)(NSString*str) = testDynamicNewFunc;
    NSLog(@"%p>>%p",(void**)&testDynamicFuncPtr,(void**)&dynamicFuncPtr);
}

- (void)test2{
    
    struct rebinding func;
    func.name = "testSelfOld";
    func.replacement = (void*)testSelfNewFunc;
    func.replaced = (void**)&selfFuncPrt;
    struct rebinding rebs[1] = {func};
    rebind_symbols(rebs, 1);
    testSelfOldFunc(10);
}

@end
