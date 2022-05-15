//
//  BlockViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/11/26.
//

#import "BlockViewController.h"
#import "BlockPerson.h"
#import "BlockDog.h"
#import <objc/runtime.h>
#import <objc/message.h>
typedef void(^BlockHandle)(void);
BlockHandle globalBlockVar_0;
int globalAge =20;
static float globalHeight =40;

@interface BlockViewController ()

@property (copy,nonatomic)BlockHandle blockVar_00;
@property (copy,nonatomic)BlockHandle blockVar_01;
@property (copy,nonatomic)BlockHandle blockVar_02;
@end

@implementation BlockViewController
- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self aboutBlockVar_00_01];
    [self circleEx];
//    111111111111111111111111111111111000
//    000101000101110100000100001100100000
//    000101000101110100000000001100100000
}

/**-----Block本质-----*/
//struct __block_impl {
//  void *isa;
//  int Flags;
//  int Reserved;
//  void *FuncPtr;
//};
//struct __BlockViewController__createBlock_block_impl_0 {
//  struct __block_impl impl;
//  struct __BlockViewController__createBlock_block_desc_0* Desc;
//  int age;
//  int *height;
//  __BlockViewController__createBlock_block_impl_0(void *fp, struct __BlockViewController__createBlock_block_desc_0 *desc, int _age, int *_height, int flags=0) : age(_age), height(_height) {
//    impl.isa = &_NSConcreteStackBlock;
//    impl.Flags = flags;
//    impl.FuncPtr = fp;
//    Desc = desc;
//  }
//};
//static void __BlockViewController__createBlock_block_func_0(struct __BlockViewController__createBlock_block_impl_0 *__cself, int one, float two) {
//  int age = __cself->age; // bound by copy
//  int *height = __cself->height; // bound by copy
//
//
//        NSLog((NSString *)&__NSConstantStringImpl__var_folders_00__gtzq88x3j3_68shnwfy_61r0000gn_T_BlockViewController_dc223a_mi_0,one,two,age,(*height));
//    }
- (void)createBlock{
    
    int age =20;
    static int height =40;
    void(^block)(int,float) = ^(int one,float two){
        
        NSLog(@"one=%d,two=%f,var=%d ,%d",one,two,age,height);
    };
    
    block(10,10.0);
}

/**-----Block变量捕获-----*/
/**-----局部变量捕获 auto变量捕获值 static变量捕获指针 auto局部变量 出作用域会释放所以捕获指针的话会出问题，出作用域内存释放了 再去访问没有，但是static变量会一直在内存中 所以捕获指针-----*/
- (void)blockGetLocalVar{
    /**-----这是捕获局部变量的block内部的方法实现-----*/
//    static void __BlockViewController__blockGetLocalVar_block_func_0(struct __BlockViewController__blockGetLocalVar_block_impl_0 *__cself, int one, float two) {
//      int age = __cself->age; // bound by copy
//      float *height = __cself->height; // bound by copy
//
//
//            NSLog((NSString *)&__NSConstantStringImpl__var_folders_00__gtzq88x3j3_68shnwfy_61r0000gn_T_BlockViewController_dc223a_mi_1,one,two,age,(*height));
//        }
    
    auto int age = 20;
    static float height =40;
    void(^block)(int,float) = ^(int one,float two){
        
        NSLog(@"one=%d,two=%f,age=%d,height=%f",one,two,age,height);
    };
    
    age =40;
    height =80;
    block(10,10.0);
}

/**-----全局变量捕获 发现block并没有捕获全局变量 直接访问 从源码中可以看出cpp文件中-----*/
- (void)blockGetGlobalVar{
    /**-----这是block捕获全局变量的方法实现，发现并没有捕获外部变量-----*/
//    static void __BlockViewController__blockGetGlobalVar_block_func_0(struct __BlockViewController__blockGetGlobalVar_block_impl_0 *__cself) {
//
//
//            NSLog((NSString *)&__NSConstantStringImpl__var_folders_00__gtzq88x3j3_68shnwfy_61r0000gn_T_BlockViewController_dc223a_mi_2,globalAge,globalHeight);
//        }

    globalBlockVar_0 = ^{
        
        NSLog(@"age=%d,height=%f",globalAge,globalHeight);
    };
    
    globalAge =40;
    globalHeight =80;
    
    globalBlockVar_0();
}

/**-----block类型-----*/
- (void)setBlockType{
    
//    没有访问auto变量Global类型block
    BlockHandle block1 =^{
      
        NSLog(@"block1");
    };
    
    static int age =3;
    BlockHandle block2=^{
        
        NSLog(@"%d",age);
    };
    
    BlockHandle block3 =^{
        
        NSLog(@"%d",globalAge);
    };
    
    
    NSLog(@"%@==block1Class,%@==block2Class,%@==block3Class",[block1 class],[block2 class],[block3 class]);
    
    // 访问auto变量Stack类型block ARC这里打印的是Malloc类型 这里是因为ARC帮我们做了事情 可以关了试一下 MRC打印Stack类型
    int age2 =3;
    BlockHandle block4 =^{
        
        NSLog(@"%d",age2);
    };
    NSLog(@"%@==block4Class",[block4 class]);
    
    /**-----StackBlock存在的问题展示-----*/
    [self stackBlockQuestionShow];
//    block调用后在这里打印是正常值 但是在如果在命令行项目main.m设置MRC 打印是一个很大的负值数字
    globalBlockVar_0();
    
    NSLog(@"%@==block4Class copy",[[block4 copy] class]);
    
    /**-----Global类型block copy后没什么变化
     Stack类型block copy后会copy到堆上 变成了Malloc类型的block
     Malloc的block copy后引用计数+1-----*/
    NSLog(@"%@==block1Class copy,%@==block4Class copy,%@==block4Class copy copy",[[block1 copy] class],[[block4 copy] class],[[[block4 copy] copy] class]);
}

- (void)stackBlockQuestionShow{
    
    int age =198;
    globalBlockVar_0 = ^{
        
        NSLog(@"%d==stackBlockQuestionShow_age,%@==globalBlockVar_0Class",age,[globalBlockVar_0 class]);
    };
    NSLog(@"%@==globalBlockVar_0Class",[globalBlockVar_0 class]);
}

/**-----block捕获对象类型 __block-----*/
- (void)objcBlock__block{
    
    __weak __block NSObject *obj =[NSObject new];
    ^{
        
        NSLog(@"%@>>>obj",obj);
    };
}

/**-----关于block内部__strong修饰的作用验证-----*/
- (void)aboutBlockVar_00_01{
    
//    NSObject *obj =[NSObject new];
//    __weak typeof(obj) weakObj =obj;
//    self.blockVar_00 =^{
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            NSLog(@"%@>>>weakObj",weakObj);
//        });
//    };
//
    NSObject *obj2 =[NSObject new];
    __weak typeof(obj2) weakObj2 =obj2;
    self.blockVar_01 =^{
        
        __strong typeof(weakObj2) strongObj2=weakObj2;
        NSLog(@"%p  %p  %p",obj2,weakObj2,strongObj2);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"%@>>>strongObj2",strongObj2);
        });
    };
    
    __weak typeof(self) weakSelf=self;
    self.blockVar_02 = ^{
      
        __strong typeof(weakSelf) strongSelf=weakSelf;
//        NSLog(@"%p  %p %p",self,weakSelf,strongSelf);
    };
    
//    self.blockVar_00();
    self.blockVar_01();
    self.blockVar_02();
    
}

- (void)circleEx{
    
//    BlockPerson *person =[[BlockPerson alloc]init];
//    BlockDog *dog =[[BlockDog alloc]init];
//    person.dog=dog;
//    {
//        BlockPerson *person2 =[[BlockPerson alloc]init];
//        dog.person=person2;
//
//    }
}
@end
