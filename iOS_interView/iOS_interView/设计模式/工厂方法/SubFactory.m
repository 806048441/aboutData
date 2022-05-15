//
//  SubFactory.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/2.
//

#import "SubFactory.h"
#import "SubOperation.h"
@implementation SubFactory

- (CalculateOperation *)creatOperation{
    
    return [SubOperation new];;
}
@end
