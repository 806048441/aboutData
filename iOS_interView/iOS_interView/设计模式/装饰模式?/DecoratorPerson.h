//
//  Person.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DecoratorPerson : NSObject

/**-----初始化方法-----*/
- (instancetype)initWithName:(NSString*)name;

- (void)show;
@end

NS_ASSUME_NONNULL_END
