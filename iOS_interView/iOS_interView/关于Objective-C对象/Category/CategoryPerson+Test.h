//
//  CategoryPerson+Test.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/26.
//

#import "CategoryPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryPerson (Test)<NSCopying,NSCoding>

@property (assign,nonatomic)int age;
@property (assign,nonatomic)double height;
- (void)test;
@end

NS_ASSUME_NONNULL_END
