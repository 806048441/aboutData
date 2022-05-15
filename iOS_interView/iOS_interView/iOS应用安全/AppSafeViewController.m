//
//  AppSafeViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/2/3.
//

#import "AppSafeViewController.h"

@interface AppSafeViewController ()

@end

@implementation AppSafeViewController

/**-----
 1.RSA 非对称加密 私钥加密 公钥解密
 2.HASH 求hash值 经常和加密算法一块用
 3.签名 签名主要用来做验证用
 例子：代码（可执行文件）-》上传App Store 后hash-》得到hash值  RSA加密hash值的结果 就是一次数字签名
 
 手机下载app 直接做hash得到一个hash值 拿到数字签名，手机系统内部有公钥，进行解密，得到hash值，两个hash值进行匹配
 如果可执行文件有篡改 hash值发生变化 就匹配不上了-----*/


/**-----
 双层签名
 mac操作系统可以生成一对公钥M 和 私钥M
 苹果手机也是iOS操作系统 公钥A 与 苹果服务器的私钥A 对应
 流程：
 1.通过mac 包装公钥M生成csr文件（钥匙串访问）此时csr文件里有公钥M 去申请证书  2.苹果服务器通过私钥A对公钥M进行一次签名 生成一个证书 + 描述文件（设备ids appid 权限文件），该证书包含公钥M、公钥M的hash值 这些都是私钥A进行加密过的
 3.Xcode在编译时会对即将安装的app通过私钥M（p12）进行一次签名，还有从苹果服务器得到的证书+ 描述文件一块打包放进app
 4.手机安装app时，拿着公钥A解密Xcode编译时打包进来的证书，解密该证书后得到公钥M
 5.通过得到公钥M，可以解密Xcode编译时的app签名。
 
 ！！！！有一点需要注意：证书是包含在描述文件里边的
 -----*/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




@end
