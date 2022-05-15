//
//  KVCPerson2.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**-----
 KVC赋值过程
 总的来说最多走3个步骤
 1.按照setKey _setKey顺序查找 如果有方法 传递参数 调用方法
 2.调用accessInstanceVariablesDirectly 返回值为YES 走第3步 如果是NO 调用setValue:forUndefinedKey: 并抛出异常NSUnknownKeyException
 3.按照_key _isKey key isKey顺序查找 如果有 直接赋值 如果没有 调用setValue:forUndefinedKey: 并抛出异常NSUnknownKeyException-----*/

//下边的过程是细分的
@interface KVCPerson2 : NSObject
{
//    第四步 查找是否有_key成员变量 有的话 直接赋值 没有走第五步
//    NSInteger _age;
//    第五步 查找是否有_key成员变量 有的话 直接赋值 没有走第六步
//    NSInteger _isAge;
//    第六步 查找是否有_key成员变量 有的话 直接赋值 没有走第七步
//    NSInteger age;
//    第七步 查找是否有_key成员变量 有的话 直接赋值 没有 调用setValue:forUndefinedKey: 并抛出异常NSUnknownKeyException
//    NSInteger isAge;
}

@end

NS_ASSUME_NONNULL_END
