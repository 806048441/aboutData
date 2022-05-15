//
//  SensorsAnalyticsSDK.h
//  SensorsSDK
//
//  Created by 神州第一坑 on 2021/12/20.
//

#import <UIKit/UIKit.h>


@interface SensorsAnalyticsSDK : NSObject

@property (strong,nonatomic)NSDictionary <NSString*,id>*automaticProperties;

+ (SensorsAnalyticsSDK*)shareInstance;
@end

