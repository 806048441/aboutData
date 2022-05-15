//
//  SensorsAnalyticsSDK.m
//  SensorsSDK
//
//  Created by 神州第一坑 on 2021/12/20.
//

#import "SensorsAnalyticsSDK.h"
#import <sys/sysctl.h>

static NSString *const SesorsAnalyticsVersion = @"1.0.0";

@implementation SensorsAnalyticsSDK

+ (SensorsAnalyticsSDK*)shareInstance{
    
    static dispatch_once_t onceToken;
    static SensorsAnalyticsSDK *ins = nil;
    dispatch_once(&onceToken, ^{
        
        ins = [[super allocWithZone:NULL]init];
    });
    return ins;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self shareInstance];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSDictionary<NSString *,id> *)automaticProperties{
    
    if (!_automaticProperties) {
        
        NSMutableDictionary *pro =[NSMutableDictionary dictionary];
        pro[@"$os"]=@"iOS";
        pro[@"$lib"]=@"iOS";
        pro[@"$manufacturer"]=@"Apple";
        pro[@"$lib_version"]=SesorsAnalyticsVersion;
        pro[@"$model"]=[self deviceModel];
        pro[@"$os_version"]=UIDevice.currentDevice.systemVersion;
        pro[@"$app_version"]=NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
        _automaticProperties =[pro copy];
    }
    return _automaticProperties;
}

- (NSString*)deviceModel{
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char answer[size];
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    NSString *result = @(answer);
    return result;
}
@end
