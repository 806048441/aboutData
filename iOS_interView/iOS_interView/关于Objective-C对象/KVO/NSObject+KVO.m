//
//  NSObject+KVO.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/23.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
@implementation NSObject (KVO)

- (void)yy_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
   
}

- (void)yy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    NSString *oldClassString= NSStringFromClass(self.class);
    NSLog(@"%@>>oldClassString",oldClassString);
    NSString *newClassString= [@"yy_" stringByAppendingString:oldClassString];
    Class newClass;
    if (!objc_getClass([newClassString UTF8String])) {
        
        newClass= objc_allocateClassPair(self.class, [newClassString UTF8String], class_getInstanceSize(self.class));
        objc_registerClassPair(newClass);
        object_setClass(self, newClass);
    }else{
        
        newClass =objc_getClass([newClassString UTF8String]);
    }
}

- (void)yy_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    
    
}

@end
