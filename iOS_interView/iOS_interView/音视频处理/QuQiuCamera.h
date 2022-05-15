//
//  QuQiuCamera.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuQiuCamera : NSObject


/// 拍照
- (void)onTakePicture;

/// 开始录制
- (void)onStartRecord;


/// 结束录制
- (void)onFinishRecord;

/// 重新拍照或录制
- (void)onRetake;
@end

NS_ASSUME_NONNULL_END
