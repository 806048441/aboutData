//
//  KVCPerson3.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**-----
 KVC取值过程
 总的来说最多走3个步骤
 1.按照getKey key isKey _key顺序查找 如果有方法 调用方法 没有方法走第2步
 2.调用accessInstanceVariablesDirectly 返回值为YES 走第3步 如果是NO 调用valueForUndefinedKey: 并抛出异常NSUnknownKeyException
 3.按照_key _isKey key isKey顺序查找 如果有 直接取值 如果没有 调用valueForUndefinedKey: 并抛出异常NSUnknownKeyException-----*/

//下边的过程是细分的
@interface KVCPerson3 : NSObject
{
    
//        第6步 查找是否有_key成员变量 有的话 直接赋值 没有走第7步
//        NSInteger _age;
//        第7步 查找是否有_key成员变量 有的话 直接赋值 没有走第8步
//        NSInteger _isAge;
//        第8步 查找是否有_key成员变量 有的话 直接赋值 没有走第9步
//        NSInteger age;
//        第9步 查找是否有_key成员变量 有的话 直接赋值 没有 调用valueForUndefinedKey: 并抛出异常NSUnknownKeyException
//        NSInteger isAge;
}
@end

NS_ASSUME_NONNULL_END
