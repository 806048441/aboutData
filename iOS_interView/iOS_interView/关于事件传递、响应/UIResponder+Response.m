//
//  UIResponder+Response.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/14.
//

#import "UIResponder+Response.h"
#import <objc/runtime.h>
@implementation UIResponder (Response)

+ (void)load {
    Method origin = class_getInstanceMethod([UIView class], @selector(hitTest:withEvent:));
    Method custom = class_getInstanceMethod([UIView class], @selector(dandJ_hitTest:withEvent:));
    method_exchangeImplementations(origin, custom);
    
    origin = class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:));
    custom = class_getInstanceMethod([UIView class], @selector(dandJ_pointInside:withEvent:));
    method_exchangeImplementations(origin, custom);
}

- (UIView *)dandJ_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@ hitTest", NSStringFromClass([self class]));
    UIView *result = [self dandJ_hitTest:point withEvent:event];
    NSLog(@"%@ hitTest return: %@", NSStringFromClass([self class]), NSStringFromClass([result class]));
    return result;
}

- (BOOL)dandJ_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%@ pointInside", NSStringFromClass([self class]));
    BOOL result = [self dandJ_pointInside:point withEvent:event];
    NSLog(@"%@ pointInside return: %@", NSStringFromClass([self class]), result ? @"YES":@"NO");
    return result;
}

@end
