//
//  MemoryTimerTarget.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/10.
//

#import "MemoryTimerTarget.h"

@implementation MemoryTimerTarget

- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    return self.taget;
}
@end
