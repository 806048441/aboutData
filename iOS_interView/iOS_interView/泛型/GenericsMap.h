//
//  GenericsMap.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenericsMap <K,V>: NSObject

- (void)put:(K)key value:(V)value;
@end

NS_ASSUME_NONNULL_END
