//
//  KVCViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/25.
//

#import "KVCViewController.h"
#import "KVCPerson.h"
#import "KVCPerson2.h"
#import "KVCPerson3.h"
#import "KVCObserver.h"
#import <objc/runtime.h>
@interface KVCViewController ()

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self addKVC];
//    [self valueForKey];
}

- (void)aboutKVCCounldObserverKVO{
    
    KVCObserver *observer =[[KVCObserver alloc]init];
    
    KVCPerson *person =[[KVCPerson alloc]init];
    [person addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [person setValue:@10 forKey:@"age"];
}

- (void)addKVC{
    
    KVCPerson2 *person =[[KVCPerson2 alloc]init];
    [person setValue:@10 forKey:@"age"];
}

- (void)valueForKey{
    
    KVCPerson3 *person =[[KVCPerson3 alloc]init];
    NSLog(@"age=%@",[person valueForKey:@"age"]);
}

@end
