//
//  MemoryTimerProxy.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemoryTimerProxy : NSProxy

@property (weak,nonatomic)id target;

@end

NS_ASSUME_NONNULL_END
