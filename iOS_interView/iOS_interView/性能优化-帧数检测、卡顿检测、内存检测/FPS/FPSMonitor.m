//
//  FPSMonitor.m
//  Aspects
//
//  Created by 神州第一坑 on 2021/4/20.
//

#import "FPSMonitor.h"
#import <UIKit/UIKit.h>
@interface FPSMonitor (){
    
    NSInteger  total;
    CFTimeInterval lastTimeStamp;
    NSInteger fps;
}
@property (strong,nonatomic)CADisplayLink * dLink;
@end

@implementation FPSMonitor


- (void)start {
    
    self.dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsCount:)];
    [self.dLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 方法执行帧率和屏幕刷新率保持一致
- (void)fpsCount:(CADisplayLink *)displayLink {
    
    if (lastTimeStamp == 0) {
        lastTimeStamp = self.dLink.timestamp;
    } else {
        total++;
        // 开始渲染时间与上次渲染时间差值
        NSTimeInterval useTime = self.dLink.timestamp - lastTimeStamp;
        if (useTime < 1) return;
        lastTimeStamp = self.dLink.timestamp;
        // fps 计算
        fps = total / useTime;
        total = 0;
        NSLog(@"%ld",fps);
    }
}
@end
