//
//  SocketShareInstance.h
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SocketInstanceDelegate <NSObject>

- (void)didReceiveMessage:(NSString*)message;

@end

@interface SocketShareInstance : NSObject

@property (nonatomic,weak)id<SocketInstanceDelegate>delegate;

+ (instancetype)sharedInstance;

- (BOOL)connectHost:(NSString*)host port:(NSInteger)port;
- (BOOL)sendMessage:(NSString*)message;
- (NSString*)read;
@end

NS_ASSUME_NONNULL_END
