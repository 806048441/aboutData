//
//  RuntimePerson.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/11/29.
//

#import "RuntimePerson.h"

@implementation RuntimePerson

- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
}

- (void)fuck:(NSDictionary*)params{
    
    NSLog(@"%s",__func__);
}


- (void)test{
    
    NSLog(@"%@=self.name",self.name);
}
@end
