//
//  SocketViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/4/20.
//

#import "SocketViewController.h"
#import "SocketShareInstance.h"
@interface SocketViewController ()

@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    BOOL result = [[SocketShareInstance sharedInstance] connectHost:@"127.0.0.1" port:9999];
    if (result) {
        
        [[SocketShareInstance sharedInstance] sendMessage:@"我牛逼的很"];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[SocketShareInstance sharedInstance] sendMessage:@(arc4random()%10).stringValue];

    [[SocketShareInstance sharedInstance] read];
}
@end
