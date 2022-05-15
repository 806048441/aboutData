//
//  RuntimeViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/11/29.
//

#import "RuntimeViewController.h"
#import "RuntimePerson.h"
#import <objc/runtime.h>
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
//    NSObject *object =[[NSObject alloc]init];
    Class cls =[RuntimePerson class];
    void *obj =&cls;
    [(__bridge id)obj test];
    
    [self performSelector:@selector(fuck:)];
    
    
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    NSMethodSignature *sig = [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(class_getInstanceMethod(RuntimePerson.class, @selector(fuck:)))];
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    NSDictionary *params = @{@"1":@"ming",@"2":@"qiang"};
    [anInvocation setArgument:&params atIndex:2];
    [anInvocation invokeWithTarget:[RuntimePerson new]];
}
@end
