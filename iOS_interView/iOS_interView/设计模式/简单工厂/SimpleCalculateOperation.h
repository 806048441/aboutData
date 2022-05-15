//
//  SimpleCalculateOperation.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleCalculateOperation : NSObject

@property (assign,nonatomic)float number1;
@property (assign,nonatomic)float number2;
- (float)calculateResult;
@end

NS_ASSUME_NONNULL_END
