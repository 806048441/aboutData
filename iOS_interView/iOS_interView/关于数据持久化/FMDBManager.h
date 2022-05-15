//
//  FMDBManager.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/13.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject

@property (strong,nonatomic)FMDatabase *db;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
