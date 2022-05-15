//
//  KVCPerson3.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/25.
//

#import "KVCPerson3.h"

@implementation KVCPerson3
- (instancetype)init{
    
    self =[super init];
    if (self) {
        
//        _age=10;
//        _isAge=20;
//        age=30;
//        isAge=40;
    }
    return self;
}

//第1步 查找是否有getKey方法 如果有 返回对应的值 如果没有走第2步
//- (NSInteger)getAge{
//
//    return 1;
//}
//第2步 查找是否有key方法 如果有 返回对应的值 如果没有走第3步
//- (NSInteger)age{
//
//    return 2;
//}
//第3步 查找是否有isKey方法 如果有 返回对应的值 如果没有走第4步
//- (NSInteger)isAge{
//
//    return 3;
//}
//第4步 查找是否有_key方法 如果有 返回对应的值 如果没有走第5步
- (NSInteger)_age{

    return 4;
}

//第5步 调用accessInstanceVariablesDirectly 如果返回值为YES 走第6步 返回值为NO 调用valueForUndefineKey: 抛出异常NSUnknownKeyException
+ (BOOL)accessInstanceVariablesDirectly{
    
    return YES;
}
@end
