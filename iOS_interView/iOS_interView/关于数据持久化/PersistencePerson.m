//
//  PersistencePerson.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/13.
//

#import "PersistencePerson.h"

@implementation PersistencePerson


- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
    [coder encodeObject:@(self.age).stringValue forKey:@"age"];
    [coder encodeObject:self.name forKey:@"name"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    
    self.name = [coder decodeObjectForKey:@"name"];
    self.age = [[coder decodeObjectForKey:@"age"]  integerValue];
    return self;
}

@end
