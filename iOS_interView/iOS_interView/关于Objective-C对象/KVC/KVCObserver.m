//
//  KVCObserver.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/25.
//

#import "KVCObserver.h"

@implementation KVCObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"keyPath=%@-object=%@-change=%@",keyPath,object,change);

}
@end
