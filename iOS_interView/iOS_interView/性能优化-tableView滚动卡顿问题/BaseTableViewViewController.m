//
//  BaseTableViewViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/14.
//

#import "BaseTableViewViewController.h"

@interface BaseTableViewViewController ()

@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UIView *csView;
@end

@implementation BaseTableViewViewController
/**-----屏幕成像是有CPU和GPU共同完成
 CPU：对象的创建、销毁 对象属性调整，布局计算，文本计算排版，图片格式解码转换，图像的绘制
 GPU：纹理渲染
 -----*/
/**-----iOS的双缓存机制
 iOS 使用的是双缓冲机制。即 GPU 会预先渲染好一帧放入一个缓冲区内（前帧缓存），让视频控制器读取，当下一帧渲染好后，GPU 会直接把视频控制器的指针指向第二个缓冲器（后帧缓存）。当你视频控制器已经读完一帧，准备读下一帧的时候，GPU 会等待显示器的 VSync 信号发出后，前帧缓存和后帧缓存会瞬间切换，后帧缓存会变成新的前帧缓存，同时旧的前帧缓存会变成新的后帧缓存。
 -----*/
/**-----关于tableView的卡顿优化
 按照60FPS的刷帧率，每隔16ms就会有一次VSync信号，当接受到VSync信号时，还没有渲染好下一帧，问题就发生了。
 因为成像和CPU、GPU息息相关，所以优化也可以从这两方面着手
 CPU：尽量使用轻量级空间布局，没有事件处理的用CALayer；
 尽量减少UIView的属性调用，比如frame、bounds、transform等属性，尽量减少不必要的修改；
 尽量少更改布局，最好一次计算好；
 iOS12之前Auto Layout消耗的CPU资源是呈指数增长，所以尽量使用frame；
 图片的话最好和frame的size保持一致；
 尽量把耗时的操作放到子线程，文本处理（尺寸计算、绘制）图片处理（解码、绘制）
 
 GPU：尽量避免短时间内大量图片的显示，尽可能将多张图片合成一张进行显示；
 GPU能处理的最大纹理尺寸是4096x4096，一旦超过这个尺寸，就会占用CPU资源进行处理，所以纹理尽量不要超过这个尺寸；
 尽量减少视图数量和层次；
 减少透明的视图（alpha<1），不透明的就设置opaque为YES；
 尽量避免出现离屏渲染；
-----*/

/**-----离屏渲染影响性能的原因
 离屏渲染会在当前屏幕缓冲区开辟另一个缓冲区进行渲染操作；所以创建新的缓冲区消耗性能；另外渲染的是时候切换缓冲区一样消耗性能；离屏渲染的整个过程，需要多次切换上下文环境，先是从当前屏幕（On-Screen）切换到离屏（Off-Screen）；等到离屏渲染结束以后，将离屏缓冲区的渲染结果显示到屏幕上，又需要将上下文环境从离屏切换到当前屏幕-----*/


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title =@"性能优化-tableView滚动卡顿问题";
    self.view.backgroundColor =[UIColor redColor];
    self.imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 80, 100)];
    self.imageView.image =[UIImage imageNamed:@"引导页-IOS1242x2688@3x"];
    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imageView];
    
    self.csView =[[UIView alloc]initWithFrame:CGRectMake(0, 210, 100, 100)];
    self.csView.backgroundColor =[UIColor purpleColor];
    [self.view addSubview:self.csView];
    [self addCorner_01];
    [self addCorner_02];
}

/**-----给图片添加圆角造成离屏渲染-----*/
- (void)addCorner_01{
    
    /**-----图片这种写法是不管用的 这种遮罩一样有离屏渲染-----*/
//    CAShapeLayer *mask =[CAShapeLayer layer];
//    mask.path =[UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)].CGPath;
//    self.imageView.layer.mask =mask;
    
    /**-----我们只设置contents或者UIImageView的image，并加上圆角+裁剪，是不会产生离屏渲染的。但如果加上了背景色、边框或其他有图像内容的图层，还是会产生离屏渲染。
     所以图片切圆角用这种方式 如果需要背景色或者其他 就加底view -----*/
    self.imageView.layer.cornerRadius=10;
    self.imageView.layer.masksToBounds=YES;
}

/**-----关于其他视图加圆角 现在直接设置cornerRadius masksToBounds=YES 也不会产生离屏渲染了-----*/
- (void)addCorner_02{
    
    self.csView.layer.cornerRadius=10;
    self.csView.layer.masksToBounds=YES;
}
@end
