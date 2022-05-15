//
//  RunloopAliveThread.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**-----线程保活 常驻线程-----*/
@interface RunloopAliveThread : NSObject

- (void)start;

- (void)exit;

- (void)excuteTask:(void(^)(void))task;
@end

NS_ASSUME_NONNULL_END
