//
//  SimpleOperatonFactory.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/1.
//

#import "SimpleOperatonFactory.h"
#import "SimpleAddOperation.h"
#import "SimpleSubOperation.h"
@implementation SimpleOperatonFactory

+ (SimpleCalculateOperation*)createOperation:(NSInteger)flag{
    
    switch (flag) {
        case 0:
            return  [SimpleAddOperation new];
            break;
        case 1:
            return  [SimpleSubOperation new];
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            return  [SimpleAddOperation new];
            break;
    }
    return nil;
}

@end
