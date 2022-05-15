//
//  NSObject+KVO.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/23.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVO)

- (void)yy_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context;

- (void)yy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)yy_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
@end

//NS_ASSUME_NONNULL_END
