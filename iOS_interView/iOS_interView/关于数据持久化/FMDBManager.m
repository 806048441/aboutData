//
//  FMDBManager.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/13.
//

#import "FMDBManager.h"
#import "MJExtension.h"
@interface FMDBManager ()

@end

@implementation FMDBManager

+ (instancetype)sharedInstance {
    
    static FMDBManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *path = @"/Users/shenzhoudiyikeng/Desktop";
        NSString *filePath = [path stringByAppendingPathComponent:@"FMDB.sqlite"];
        NSLog(@"数据库路径：%@",filePath);
        sharedInstance = [[super allocWithZone:NULL] init];
        sharedInstance.db = [FMDatabase databaseWithPath:filePath];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}
- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}

@end
