//
//  SensorsViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/20.
//

#import "SensorsViewController.h"
@interface SensorsViewController ()

@end

@implementation SensorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
}

/**-----
 数据处理过程:数据采集 数据传输 数据建模 数据统计、分析、挖掘 数据可视化、反馈
 埋点：则主要处理数据采集 功能：通过埋点采集数据，然后将采集的数据传输给服务器
 原则：保证数据的完整性、准确性、及时性
 埋点的三种类型：1代码埋点 2全埋点  3可视化埋点
 1代码埋点:优点有精准控制埋点位置，灵活自定义事件，采集更丰富和业务相关的数据，满足更细化的需求划分；缺点有埋点成本较高，若有需求分析发生变化或者设计发生变化则程序也需要修改并发版。
 2全埋点:无需写代码或者只写少量代码完成收集用户所有或者绝大部分的行为数据，然后根据实际业务分析需求筛选数据进行分析。全埋点采集事件包括：应用启动，退出，页面浏览，控件单击，应用程序crash等。优点有埋点成本低，即使需求分析有更改也不用写代码修改埋点或者发版，有效解决“历史数据回溯”问题；缺点很难坐到全面覆盖（一些复杂操作，缩放滚动等），无法采集具体业务的数据，无法满足更精细的需求划分。
 3可视化埋点：默认情况下不埋点，通过可视化方式指定给某些控件埋点；默认情况下全埋点，通过可视化给某些控件不埋点-----*/
@end
