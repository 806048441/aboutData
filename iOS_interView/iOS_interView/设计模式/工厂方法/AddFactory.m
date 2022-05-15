//
//  AddFactory.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/2.
//

#import "AddFactory.h"
#import "AddOperation.h"
@implementation AddFactory

- (CalculateOperation *)creatOperation{
    
    return [AddOperation new];;
}
@end
