//
//  PictureViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/2/19.
//

#import "PictureViewController.h"
#import "AFNetworking.h"
#import <objc/runtime.h>
static NSString *const PIC_URL = @"https://4d2f-223-88-79-177.ngrok.io/pictures/name1.jpg";

@interface PictureViewController ()

@property (strong,nonatomic)UIImageView *imageView;
@end

/**-----主要要研究一下 图片压缩 解码 编码 上传 下载等-----*/
@implementation PictureViewController
- (void)dealloc {
    
    NSLog(@"---%s----",__func__);
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 300, 300)];
    [self.view addSubview:self.imageView];
    
//    NSMethodSignature *signature =[self methodSignatureForSelector:@selector(compressionBigImage2)];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    [invocation setTarget:self];
//    [invocation setSelector:@selector(compressionBigImage2)];
//    [invocation invoke];
    
//    NSMethodSignature *si2 =[NSMethodSignature signatureWithObjCTypes:"v24@0:8@16"];
//    NSInvocation *invocation =[NSInvocation invocationWithMethodSignature:si2];
//    [invocation setTarget:self];
//    [invocation setSelector:@selector(printStr:)];
//    NSString *str =@"123";
//    [invocation setArgument:&str atIndex:2];
//    [invocation invoke];
//
//    Method method = class_getInstanceMethod(PictureViewController.class, @selector(printStr:));
//    NSLog(@"%s",method_getTypeEncoding(method));
    
    [self compressionBigImage2];
}

- (void)printStr:(NSString*)str{
    
    NSLog(@"%@",str);
}
- (void)compressionBigImage{
    
    UIImage *originImage = [UIImage imageNamed:@"超大图2.jpg"];
    NSData *compressionData= UIImageJPEGRepresentation(originImage, 1);
    NSData *compressionData2=UIImagePNGRepresentation(originImage);
    NSLog(@"%f--UIImageJPEGRepresentation",compressionData.length/1024.0/1024.0);
    NSLog(@"%f--UIImagePNGRepresentation",compressionData2.length/1024.0/1024.0);
    UIImage *presentImage=[UIImage imageWithData:compressionData];
    NSLog(@"%@>>",NSStringFromCGSize(presentImage.size));
}


- (size_t)getImageBitmapSize:(UIImage *)image {
 
    CGImageRef imageRef = image.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, width, height, 8, 0, space, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault);
    CGContextDrawImage(ctx, CGRectMake( 0, 0, width, height), imageRef);
    size_t perRow = CGImageGetBytesPerRow(imageRef);
    size_t size = perRow * height;
    CFRelease(ctx);
    NSLog(@"size %@B,  %@K, %@M",@(size), @(size/1024), @(size/1024/1024));
    return size;
}


- (void)compressionBigImage2{
    
    UIImage *originImage = [UIImage imageNamed:@"IMG_2481.JPG"];
    NSData *data = UIImageJPEGRepresentation(originImage, 1);
    CFDataRef rawData = CGDataProviderCopyData(CGImageGetDataProvider(originImage.CGImage));
    CFRelease(rawData);
    self.imageView.image = originImage;
//    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    __block NSData *compressionData;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        NSLog(@"%f",sqrtf(4.0));
//        compressionData = [self compressBySizeWithMaxLength2:1024*1024*1 image:originImage];
//        NSLog(@"%f",compressionData.length/1024.0/1024.0);
//        dispatch_semaphore_signal(sem);
//    });
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//    UIImage *presentImage=[UIImage imageWithData:compressionData];
//    self.imageView.image = presentImage;
//    NSLog(@"%@>>",NSStringFromCGSize(presentImage.size));
}

- (NSData *)compressBySizeWithMaxLength:(NSInteger)maxLength image:(UIImage*)image{
    
   CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

-(NSData *)compressBySizeWithMaxLength2:(NSUInteger)maxLength image:(UIImage*)image{
    UIImage *resultImage = image;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        // Use image to draw (drawInRect:), image is larger but more compression time
        // Use result image to draw, image is smaller but less compression time
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return data;
}

- (void)uploadImage{
        
    AFHTTPSessionManager *manager =[[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    UIImage *originImage = [UIImage imageNamed:@"超大图2.jpg"];
    NSData *compressionData= UIImageJPEGRepresentation(originImage, 0.0001);
    [manager POST:PIC_URL parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFormData:compressionData name:@"name1"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%lld",uploadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
