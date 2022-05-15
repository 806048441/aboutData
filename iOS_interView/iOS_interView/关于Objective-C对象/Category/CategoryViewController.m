//
//  CategoryViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/26.
//

#import "CategoryViewController.h"
#import "InitializeMethodPerson.h"
#import "InitializeMethodMan.h"
#import "CategoryPerson.h"
#import <objc/message.h>
@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor blueColor];
    
    [self categoryCover];
}

/**-----关于load方法
 调用时机：在runtime加载类和分类的时候调用
 调用方式：直接找到方法地址、直接调用
 调用顺序：先调用类的load方法 多个类的时候 按照编译顺序调用 先编译先调用 如果该类存在父类则先调用父类的load方法 这都是源码递归实现的 然后分别调用分类的load方法 也就是每个类、分类的方法都会调用 同样按照编译顺序调用 先编译先调用
 该项目中我设置的编译顺序LoadMethodMan在LoadMethodPerson前  LoadMethodMan继承与LoadMethodPerson LoadMethodPerson的load会先调用
 LoadMethodMan+One的编译顺序同样在前LoadMethodPerson+One前 这个则完全相反 分类的load调用没有递归找父类调用 而是直接按照编译顺序调用-----*/

/**-----关于initialize方法
 调用时机：在第一次要发送消息的时候调用
 调用方式：通过objc_msgSend调用
 调用顺序：因为走的objc_msgSend消息发送，所以当分类有这个方法时肯定会调用分类的initialize方法而不调用原来的类的，调用时会先查找父类是否调用过，如果没有则父类先调用，源码中也是递归实现。如果子类没有实现initialize方法，当子类调用该方法时，父类的该方法相当于会调用两次，第一次是递归中判断父类没有initialize调用，第二次是子类调用的时候通过superClass查找调用-----*/

- (void)callInitializeEx{
    
    [InitializeMethodPerson alloc];
}

- (void)callSubInitializeEx{
    
    [InitializeMethodMan alloc];
}

- (void)categoryCover{
    
    CategoryPerson *person =[[CategoryPerson alloc]init];
    [person test];
    
    //如何重新调用原来类的这个方法
    unsigned methodListCount;
    Method *methodList = class_copyMethodList(person.class, &methodListCount);
    for (int i=methodListCount; i>=0; i--) {
        
        Method method = methodList[i];
        SEL sel = method_getName(method);
        if ([NSStringFromSelector(sel) isEqualToString:@"test"]) {
            
//            NSMethodSignature *si = [person methodSignatureForSelector:sel];
//            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:si];
//            [inv setSelector:sel];
//            [inv invokeWithTarget:person];
            
            IMP imp = method_getImplementation(method);
            ((void (*)(id, SEL))imp)(person,sel);
            ((void (*)(id, SEL))objc_msgSend)(person,sel);
            break;
        }
    }
}
@end
