//
//  Decorator.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/3.
//

#import "Decorator.h"

@interface Decorator ()

{
    DecoratorPerson *_person;
}

@end

@implementation Decorator

- (instancetype)initWithPerson:(DecoratorPerson*)person{
    
    self =[super init];
    if (self) {
        
        _person = person;
    }
    return self;
}

- (void)show{
    
    if (_person) {
        
        [_person show];
    }
}
@end
