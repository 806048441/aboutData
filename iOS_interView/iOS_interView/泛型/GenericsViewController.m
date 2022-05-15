//
//  GenericsViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/4/6.
//

#import "GenericsViewController.h"
#import "GenericsMap.h"
@interface GenericsViewController ()

@end

@implementation GenericsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"1234567890asdfghhhhhhhhh"];
    NSLog(@"%@",dic[@"1234567890asdfghhhhhhhhh"]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
