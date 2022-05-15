//
//  KVOViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/18.
//

#import "KVOViewController.h"
#import "KVOPerson.h"
#import "NSObject+KVO.h"
#import <objc/runtime.h>
@interface KVOViewController ()

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self customAddKVO];
}

//iOS用什么方式实现对一个对象的KVO？(KVO的本质是什么？)
//利用RuntimeAPI动态生成一个子类，并且让instance对象的isa指向这个全新的子类
//当修改instance对象的属性时，会调用Foundation的_NSSetXXXValueAndNotify函数
//willChangeValueForKey:
//父类原来的setter
//didChangeValueForKey:
//内部会触发监听器（Oberser）的监听方法( observeValueForKeyPath:ofObject:change:context:）


//如何手动触发KVO？
//手动调用willChangeValueForKey:和didChangeValueForKey:


//直接修改成员变量会触发KVO么？
//不会触发KVO
- (void)addKVO{
    
    KVOPerson *person =[[KVOPerson alloc]init];
    KVOPerson *person2 =[[KVOPerson alloc]init];
    NSLog(@"%p %p",[person methodForSelector:@selector(setHeight:)],[person2 methodForSelector:@selector(setHeight:)]);
    [person addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    NSLog(@"%p %p",[person methodForSelector:@selector(setHeight:)],[person2 methodForSelector:@selector(setHeight:)]);
    NSLog(@"%@ %@",object_getClass(person),object_getClass(object_getClass(person)));
    NSLog(@"%p %p",object_getClass(person),object_getClass(object_getClass(person)));
//    下边是控制台输出 调试
//    2021-10-18 22:28:46.962594+0800 iOS_interView[68648:5467800] 0x10b43bf10 0x10b43bf10
//    2021-10-18 22:28:46.962881+0800 iOS_interView[68648:5467800] 0x7fff207a3824 0x10b43bf10
//    2021-10-18 22:28:46.963000+0800 iOS_interView[68648:5467800] NSKVONotifying_KVOPerson NSKVONotifying_KVOPerson
//    2021-10-18 22:28:46.963091+0800 iOS_interView[68648:5467800] 0x600000698240 0x600000698510
//    (lldb) p (IMP) 0x103024f90
//    (IMP) $0 = 0x0000000103024f90 (iOS_interView`-[KVOPerson setHeight:] at KVOPerson.h:14)
//    (lldb) p (IMP) 0x7fff207a3824
//    (IMP) $1 = 0x00007fff207a3824 (Foundation`_NSSetFloatValueAndNotify)
//    (lldb) p person.isa
//    (Class) $2 = NSKVONotifying_KVOPerson
//      Fix-it applied, fixed expression was:
//        person->isa
//    (lldb) p person2.isa
//    (Class) $3 = KVOPerson
//      Fix-it applied, fixed expression was:
//        person2->isa
    
    [self printMethodOfClass:object_getClass(person)];
//    2021-10-23 14:41:12.052337+0800 iOS_interView[78605:5946908] setHeight:
//    2021-10-23 14:41:12.052438+0800 iOS_interView[78605:5946908] class
//    2021-10-23 14:41:12.052535+0800 iOS_interView[78605:5946908] dealloc
//    2021-10-23 14:41:12.052613+0800 iOS_interView[78605:5946908] _isKVOA
//    NSKVONotifying_KVOPerson重写了以上这几个方法
}

- (void)customAddKVO{
    
    KVOPerson *person =[[KVOPerson alloc]init];
    KVOPerson *person2 =[[KVOPerson alloc]init];
    [person yy_addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)printMethodOfClass:(Class)class{
    
    unsigned count;
    Method *methodList= class_copyMethodList(class, &count);
    for (int i=0; i<count; i++) {
        
        Method method = methodList[i];
        NSLog(@"%@",NSStringFromSelector(method_getName(method)));
    }
    free(methodList);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"keyPath=%@-object=%@-change=%@",keyPath,object,change);
}

- (void)yy_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
}

@end
