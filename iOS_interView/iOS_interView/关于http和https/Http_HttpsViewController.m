//
//  Http_HttpsViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/1/27.
//

#import "Http_HttpsViewController.h"

@interface Http_HttpsViewController ()

@end

@implementation Http_HttpsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
}

/**-----https建立连接流程
 1.客户端请求 发送tls版本 一个随机数random_c 支持的加密算法 支持的压缩方法
 2.服务端返回 发送tls版本 一个随机数random_s 选择的加密算法 证书
 3.客户端验证证书是否合法 ip是否对得上 证书是否过期 是否是可信任机构颁布 如果过的去 从证书中取出公钥 然后发送一个对称秘钥（该秘钥是由random_c+random_s+预主秘钥 通过服务端的公钥构成）发送编码改变通知，告诉服务器以后通信用双方协定的加密算法和秘钥通信 发送握手结束通知 这一项是前边发送所有内容的hash值，用来让服务器校验
 4.服务器收到客户端发送的第三个随机数，计算生成本次会话所用的“会话秘钥” 然后向客户端发送编码改变通知告诉客户端以后通信用双发协定加密算法和秘钥通信 握手结束通知 这一项也是前边发送所有内容的hash值 供客户端校验 -----*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
