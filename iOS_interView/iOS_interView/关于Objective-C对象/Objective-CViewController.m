//
//  Objective-CViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/16.
//

#import "Objective-CViewController.h"
#import "LearningMaterialCell.h"
#import <objc/runtime.h>
#import "BlockPerson.h"
@interface Objective_CViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSArray *objcs;
@property (strong,nonatomic)NSArray *objcViewControllers;
@end

@implementation Objective_CViewController
- (void)dealloc {
        
    NSLog(@"---%s----",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    struct rlimit r;
//    getrlimit(RLIMIT_STACK,&r);
//    NSLog(@"###(%lld, %lld)", r.rlim_cur, r.rlim_max);
//
//    //设置新的栈大小
//    r.rlim_cur=r.rlim_cur -3;       // 增大当前的栈大小，mac上可以这样调，只要目标值 < rlim_max即可
//    //r.rlim_max = r.rlim_max * 2;  // rlim_max不能被增大，这样设置时调用 setrlimit 会失败
//    int ret = setrlimit(RLIMIT_STACK,&r);
    
    self.definesPresentationContext = YES;

    NSLog(@"%p>>%p>>%p",self,[self class],object_getClass(self));

    self.navigationItem.title =@"关于Objective-C对象";
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
    for (int i=0; i<1000; i++) {
        
        UIView *obj =[[UIView alloc]init];
        NSLog(@"%p %p %p",obj,object_getClass(obj),[obj class]);
    }
}

#pragma mark - customer
- (UITableView *)myTableView{
    
    if (!_myTableView) {
        
        _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            
            _myTableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
        _myTableView.showsVerticalScrollIndicator=NO;
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.estimatedRowHeight=44;
        [_myTableView registerClass:[LearningMaterialCell class] forCellReuseIdentifier:@"LearningMaterialCell"];
    }
    return _myTableView;
}

- (NSArray *)objcs{
    
    if (!_objcs) {
        
        _objcs = @[
            @"OC对象、指针、isa、instance对象、class对象、meta-Class对象",
            @"KVO",
            @"KVC",
            @"Category"];
    }
    return _objcs;
}

- (NSArray *)objcViewControllers{
    
    if (!_objcViewControllers) {
        
        _objcViewControllers =@[
            @"ObjcViewController",
            @"KVOViewController",
            @"KVCViewController",
            @"CategoryViewController"
        ];
    }
    return _objcViewControllers;
}

#pragma mark - privite
- (void)timerMethod{
    
    NSLog(@"-----");
}

#pragma mark - protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.objcs.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LearningMaterialCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LearningMaterialCell"];
    cell.label.text=self.objcs[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *classString =self.objcViewControllers[indexPath.row];
    UIViewController *viewController =[[NSClassFromString(classString) alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
