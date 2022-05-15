//
//  CrashViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/19.
//

#import "CrashViewController.h"

@interface CrashViewController ()

@property (copy,nonatomic)NSString *taggedQName;
@end

@implementation CrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self crash5];
}


/// 数组越界
- (void)crash1{
    
    NSArray *array= @[@"1"];
    NSLog(@"%@",array[1]);
}


/// 方法未实现
- (void)crash2{
    
    [self performSelector:@selector(test)];
}


/// 死锁 多线程问题 捕获不到
- (void)crash3{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
       
        NSLog(@"laile");
    });
}


/// 子线程刷新UI 并不一定会崩溃
- (void)crash4{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        self.view.backgroundColor =[UIColor blueColor];
    });
}

- (void)crash5{
    
    //    这种会产生安全问题 多个线程同时调用某方法setter方法 setter内部实现是 先release原来的 再retain现在的赋值 当release后 另一个线程再去调用 会再release release一个不存在的 会崩溃内存访问
        
        dispatch_queue_t queue =dispatch_get_global_queue(0, 0);
        for (int i =0; i<1000; i++) {
            
            dispatch_async(queue, ^{
               
                self.taggedQName = [NSString stringWithFormat:@"%d abcdedfghijk",i];
            });
        }
}
@end
