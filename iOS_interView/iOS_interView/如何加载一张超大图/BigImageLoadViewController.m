//
//  BigImageLoadViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/14.
//

#import "BigImageLoadViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImage.h"
#import <YYKit/YYKit.h>
#import "UIImageView+AppleLargeImage.h"
#import "YPLargeImageView.h"
#define BASE_URL @"https://3a72-42-232-59-201.ngrok.io/pictures"
#define B_URL [NSURL fileURLWithPath:@"/Users/shenzhoudiyikeng/Documents/LearnForInterface/iOS_interView/iOS_interView/如何加载一张超大图/超大图2.jpg"]

@interface BigImageLoadCell : UITableViewCell

@property (strong,nonatomic)UIImageView *bigImageView;
@end

@implementation BigImageLoadCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.bigImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
        self.bigImageView.contentMode=UIViewContentModeScaleAspectFill;
        self.bigImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.bigImageView];
        
        [self.bigImageView sd_setImageWithURL:nil];
    }
    return self;
}

@end

@interface BigImageLoadViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)YPLargeImageView *largeImageView;
@end

@implementation BigImageLoadViewController

- (void)dealloc {
    
    NSLog(@"%ldM==yycache.size，count=%ld",[YYImageCache sharedCache].memoryCache.totalCost/1024/1024,[YYImageCache sharedCache].memoryCache.totalCount);
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjects];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"关于超大图加载";
    [[SDImageCache sharedImageCache] clearMemory];
    
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjects];
   
    self.view.backgroundColor =[UIColor whiteColor];
    [self largeImage_02];
//    [self.view addSubview:self.myTableView];
}
#pragma mark - customer
- (UITableView *)myTableView{
    
    if (!_myTableView) {
        
        _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            
            _myTableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
        _myTableView.showsVerticalScrollIndicator=NO;
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        [_myTableView registerClass:[BigImageLoadCell class] forCellReuseIdentifier:@"BigImageLoadCell"];
    }
    return _myTableView;
}

- (UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView =[[UIImageView alloc]initWithFrame:self.view.bounds];
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (YPLargeImageView *)largeImageView{
    
    if (!_largeImageView) {
        
        _largeImageView =[[YPLargeImageView alloc]initWithFrame:self.view.bounds];
        _largeImageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _largeImageView;
}

#pragma mark - privite
- (void)largeImage_01{
    
    /**-----图片分辨率过大加载不出来-----*/
    //    self.imageView.image =[UIImage imageNamed:@"超大图2.jpg"];
    [self.view addSubview:self.imageView];
    self.imageView.image =[[UIImage alloc]initWithContentsOfFile:@"超大图2.jpg"];
}

- (void)largeImage_02{
    
    [self.view addSubview:self.imageView];
    [self.imageView yp_setLargeImageWithName:@"超大图2.jpg"];
}

- (void)largeImage_03{
    
    [self.view addSubview:self.largeImageView];
    [self.largeImageView yp_setImageName:@"超大图2.jpg"];
}

#pragma mark - protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BigImageLoadCell *cell =[tableView dequeueReusableCellWithIdentifier:@"BigImageLoadCell"];
    NSURL *url =[NSURL URLWithString:[BASE_URL stringByAppendingPathComponent:@"bigbig1.jpeg"]];
    NSURL *url2 =[NSURL URLWithString:[BASE_URL stringByAppendingPathComponent:@"bigbig3.jpg"]];
    NSURL *useUrl = arc4random()%2?url:url2;
    
//    UIImage *image = [self downsampleImageAt:useUrl to:CGSizeMake(self.view.bounds.size.width, 300) scale:1];
//    cell.bigImageView.image = image;
    
//    [cell.bigImageView yy_setImageWithURL:useUrl placeholder:nil];
//    [cell.bigImageView sd_setImageWithURL:useUrl];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}

// 大图缩小为显示尺寸的图
- (UIImage *)downsampleImageAt:(NSURL *)imageURL to:(CGSize)pointSize scale:(CGFloat)scale {
    // 利用图像文件地址创建 image source
    NSDictionary *imageSourceOptions =
  @{
    (__bridge NSString *)kCGImageSourceShouldCache: @NO // 原始图像不要解码
    };
    CGImageSourceRef imageSource =
    CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL, (__bridge CFDictionaryRef)imageSourceOptions);

    // 下采样
    CGFloat maxDimensionInPixels = MAX(pointSize.width, pointSize.height) * scale;
    NSDictionary *downsampleOptions =
    @{
      (__bridge NSString *)kCGImageSourceCreateThumbnailFromImageAlways: @YES,
      (__bridge NSString *)kCGImageSourceShouldCacheImmediately: @YES,  // 缩小图像的同时进行解码
      (__bridge NSString *)kCGImageSourceCreateThumbnailWithTransform: @YES,
      (__bridge NSString *)kCGImageSourceThumbnailMaxPixelSize: @(maxDimensionInPixels)
       };
    CGImageRef downsampledImage =
    CGImageSourceCreateThumbnailAtIndex(imageSource, 0, (__bridge CFDictionaryRef)downsampleOptions);
    UIImage *image = [[UIImage alloc] initWithCGImage:downsampledImage];
    CGImageRelease(downsampledImage);
    CFRelease(imageSource);

    return image;
}
@end
