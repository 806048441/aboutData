//
//  SocketShareInstance.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/4/20.
//

#import "SocketShareInstance.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface SocketShareInstance ()

@property (assign,nonatomic)int clientSocket;
@end


@implementation SocketShareInstance

+ (instancetype)sharedInstance {
    
    static SocketShareInstance *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[super allocWithZone:NULL] init];
        // 1.创建客户端Socket
            /**
             参数
             参数1 : domain,协议域/协议簇，AF_INET（IPV4的网络开发）
             参数2 : type,Socket类型，SOCK_STREAM(TCP)/SOCK_DGRAM(UDP，报文)
             参数3 : protocol,IPPROTO_TCP，协议，如果输入0，可以根据第二个参数，自动选择协议

             返回值
             int类型,如果 > 0 就表示创建客户端Socket成功,返回socket
             */
            sharedInstance.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
            if (sharedInstance.clientSocket > 0) {
                NSLog(@"创建客户端Socket成功");
            }
    });
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
