//
//  PersistencePerson.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersistencePerson : NSObject<NSCoding>

@property (assign,nonatomic)NSInteger age;
@property (copy,nonatomic)NSString *name;
@property (copy,nonatomic)NSString *nickName;
@end

NS_ASSUME_NONNULL_END
