//
//  Person.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/3.
//

#import "DecoratorPerson.h"

@interface DecoratorPerson ()
{
    NSString *_name;
}
@end

@implementation DecoratorPerson

- (instancetype)initWithName:(NSString*)name{
    
    self =[super init];
    if (self) {
        
        _name = name;
    }
    return self;
}

- (void)show{
    
    
}
@end
