//
//  ViewController.m
//  关于Objective-C对象
//
//  Created by 神州第一坑 on 2021/10/12.
//

#import "ViewController.h"
#import "Objective-CViewController.h"
#import "LearningMaterialCell.h"
#import <objc/runtime.h>
#import "YYKitMacro.h"
#import "CSTF.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSArray *learningMaterials;
@property (strong,nonatomic)NSArray *learningViewControllers;
@property (strong,nonatomic)UIViewController *vccc;
@property (strong,nonatomic)UILabel *inputLabel;
@end

@implementation ViewController


//#ifndef YYSYNTH_DYNAMIC_PROPERTY_OBJECT
//#define YYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
//- (void)_setter_ : (_type_)object { \
//    [self willChangeValueForKey:@#_getter_]; \
//    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
//    [self didChangeValueForKey:@#_getter_]; \
//} \
//- (_type_)_getter_ { \
//    return objc_getAssociatedObject(self, @selector(_setter_:)); \
//}
//#endif

YYSYNTH_DYNAMIC_PROPERTY_OBJECT(textF, setTextF, RETAIN_NONATOMIC, CSTF*)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"Main";
    self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
    
  
    

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        for (int i=0; i<100; i++) {
//
//            NSLog(@"%@",[NSThread currentThread]);
//        }
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        for (int i=0; i<100; i++) {
//
//            NSLog(@"%@",[NSThread currentThread]);
//        }
//    });
}

#pragma mark - customer

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return  YES;
}

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

- (NSArray *)learningMaterials{
    
    if (!_learningMaterials) {
        
        _learningMaterials = @[@"OC对象、指针、isa、instance对象、class对象、meta-Class对象；KVO；KVC；Category",@"Block",@"Runtime",@"Runloop",@"内存管理",@"多线程",@"性能优化-tableView滚动卡顿问题",@"关于超大图加载",@"关于事件传递、响应",@"关于Crash",@"关于埋点",@"关于http和https",@"关于SDWebImage",@"图片问题",@"设计模式",@"关于fishhook",@"数据持久化",@"泛型",@"Socket"];
    }
    return _learningMaterials;
}

- (NSArray *)learningViewControllers{
    
    if (!_learningViewControllers) {
        
        _learningViewControllers =@[@"Objective_CViewController",@"BlockViewController",@"RuntimeViewController",@"RunloopViewController",@"MemeoryViewController",@"ThreadViewController",@"BaseTableViewViewController",@"BigImageLoadViewController",@"ResponseTransferViewController",@"CrashViewController",@"SensorsViewController",@"Http_HttpsViewController",@"SDWebImageViewController",@"PictureViewController",@"DesignPatternsViewController",@"FishhookViewController",@"DataPersistenceViewController",@"GenericsViewController",@"SocketViewController"];
    }
    return _learningViewControllers;
}

#pragma mark - protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.learningMaterials.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LearningMaterialCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LearningMaterialCell"];
    cell.label.text=self.learningMaterials[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *classString =self.learningViewControllers[indexPath.row];
    UITextField *tf = [self textF];
    UIViewController *viewController =[[NSClassFromString(classString) alloc]init];
    self.vccc = viewController;
    tf.delegate = viewController;
    [tf resignFirstResponder];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
