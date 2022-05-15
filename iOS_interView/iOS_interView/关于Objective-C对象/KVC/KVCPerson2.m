//
//  KVCPerson2.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/25.
//

#import "KVCPerson2.h"

@implementation KVCPerson2

//第一步 查找是否是setKey方法 有的话 传递参数 直接调用 没有的话走第二步
//- (void)setAge:(NSInteger)age{
//
//    NSLog(@"---%s----",__func__);
//
//}
//第二步 查找是否是_setKey方法 有的话 传递参数 直接调用 没有的话走第三步
- (void)_setAge:(NSInteger)age{
 
    NSLog(@"---%s----",__func__);

}

//第三步 调用accessInstanceVariablesDirectly 如果返回值是YES 走第四步 如果返回值是NO 调用setValue:forUndefinedKey: 并抛出异常NSUnknownKeyException
//+ (BOOL)accessInstanceVariablesDirectly{
//    
//    return YES;
//}
@end
