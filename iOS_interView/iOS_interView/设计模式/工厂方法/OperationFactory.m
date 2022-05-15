//
//  OperationFactory.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/2.
//

#import "OperationFactory.h"
#import "CalculateOperation.h"
@implementation OperationFactory

- (CalculateOperation*)creatOperation{
    
    return [[CalculateOperation alloc]init];
}
@end
