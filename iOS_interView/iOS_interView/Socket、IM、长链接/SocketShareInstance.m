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

- (BOOL)connectHost:(NSString*)host port:(NSInteger)port{
    
    // 2.客户端Socket连接到服务器Socket
    /**
     参数
     参数1 :  客户端socket
     参数2 :  指向数据结构sockaddr的指针，其中包括目的端口和IP地址
     服务器的"结构体"地址
     提示：C 语言中没有对象
     参数3 :  结构体数据长度
     
     返回值
     0 成功/其他 错误代号，(不是非0即真)
     */
    
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = inet_addr([host UTF8String]);
    
    int isConnected = connect(self.clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (isConnected == 0) {
        return YES;
    }
    
    
  
    
   
    return NO;
}

- (BOOL)sendMessage:(NSString*)message{
    
    // 3.客户端Socket向服务器Socket发送请求
    /**
     参数
     参数1 : 客户端socket
     参数2 : 发送内容地址 void * == id
     参数3 : 发送内容长度
     参数4 : 发送方式标志，一般为0
     
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     */
    
    //        NSString *sendMsg = @"GET / HTTP/1.1\r\n"
    //                            "Host: www.baidu.com\r\n"
    //                            "User-Agent: iphone\r\n"
    //                            "Connection: close\r\n\r\n"
    //                            ;
    
    ssize_t sendCount = send(self.clientSocket, message.UTF8String, strlen(message.UTF8String), 0);
    NSLog(@"发送字符数 %ld",sendCount);
    return sendCount != kCFSocketError;
}

- (NSString *)read{
    
    // 4.客户端Socket接收服务器Socket发送的数据(响应)
    /**
     参数
     参数1 : 客户端socket
     参数2 : 接收内容缓冲区地址
     参数3 : 接收内容缓存区长度
     参数4 : 接收方式，0表示阻塞，必须等待服务器返回数据
     
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
     
     提示 : 服务器发送给客户端数据时,是一点一点发送的
     提示 : 当服务器把数据都发送完了以后,再次发送时,只发送0字节,
     */
    // 创建接收服务器发送的数据的容器 / 缓冲区 ,并且指定了容量
    uint8_t buffer[1024];
    // 需要创建一个容器
    NSMutableData *dataM = [NSMutableData data];
    
    // 循环的接收服务器发送的数据
    ssize_t recvCount = -1;
    while (recvCount != 0) {
        // 值接收了一次
        recvCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
        NSLog(@"接收的内容数 %ld",recvCount);
        [dataM appendBytes:buffer length:recvCount];
    }
    NSString *html = [[NSString alloc] initWithData:dataM encoding:NSUTF8StringEncoding];
    NSLog(@"%@",html);
    return html;
}
@end
