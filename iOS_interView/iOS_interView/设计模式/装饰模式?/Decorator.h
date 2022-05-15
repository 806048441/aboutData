//
//  Decorator.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/3.
//

#import "DecoratorPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface Decorator : DecoratorPerson

/**-----初始化装饰类的方法-----*/
- (instancetype)initWithPerson:(DecoratorPerson*)person;
@end

NS_ASSUME_NONNULL_END
