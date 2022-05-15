//
//  OperationFactory.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/2.
//

#import <Foundation/Foundation.h>
@class CalculateOperation;
NS_ASSUME_NONNULL_BEGIN

@interface OperationFactory : NSObject

- (CalculateOperation*)creatOperation;
@end

NS_ASSUME_NONNULL_END
