//
//  ResponseTransferViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/14.
//

#import "ResponseTransferViewController.h"
#import "ResponseTransferButton.h"
#import "ResponseTransferView.h"
@interface ResponseTransferViewController ()

@property (strong,nonatomic)UIView *customView;
@property (strong,nonatomic)ResponseTransferView *responseView;
@end

@implementation ResponseTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
//    [self responseTransfer_01];
    
    [self buttonResponse];
}
/**-----关于事件传递
 UIApplication接收到事件后 会放到系统的队列里去FIFO 例如某个点击事件
 找响应视图 先判断该视图的交互性、透明度、隐藏属性
 UIWindow pointInSide:返回YES hitTest返回该对象；
 然后 找到从后往前遍历UIWindow的子视图，同样调用pointInSide:如果返回YES hitTest返回该对象，如果返回NO hitTest返回nil 找兄弟视图 直到找到最底的-----*/

/**-----关于事件响应
 当收到事件传递、确定响应视图时；会从下往上，判断该视图是否处理了响应事件，如果没有处理则找到他的nextResponse，直到找到处理事件的父视图，如果找到UIApplication还没有处理，那事件就不处理;
 -----*/

- (void)responseTransfer_01{
    
    NSArray *arr;

    self.customView =[[UIView alloc]initWithFrame:CGRectMake(0, 100, 200, 200)];
    self.customView.backgroundColor =[UIColor blueColor];
    [self.view addSubview:self.customView];
    
    self.responseView =[[ResponseTransferView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.responseView.backgroundColor=[UIColor purpleColor];
    [self.customView addSubview:self.responseView];
}
/**-----button有多个响应事件 到底响应哪个-----*/
- (void)buttonResponse{
    
    ResponseTransferButton *button =[[ResponseTransferButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    button.backgroundColor=[UIColor redColor];
    [self.view addSubview:button];
//    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonTap)];
//    [button addGestureRecognizer:tap];
//    
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTap{
    
    NSLog(@"%s",__func__);
}

- (void)buttonClick{
    
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s",__func__);
}
@end
