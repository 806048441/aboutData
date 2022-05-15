//
//  SimpleOperatonFactory.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/1.
//

#import <Foundation/Foundation.h>
@class SimpleCalculateOperation;
NS_ASSUME_NONNULL_BEGIN

@interface SimpleOperatonFactory : NSObject

+ (SimpleCalculateOperation*)createOperation:(NSInteger)flag;
@end

NS_ASSUME_NONNULL_END
