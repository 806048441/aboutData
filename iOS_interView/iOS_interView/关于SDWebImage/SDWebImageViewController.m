//
//  SDWebImageViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/1/28.
//

#import "SDWebImageViewController.h"
#import "SDWebImagePerson.h"
@interface SDWebImageViewController ()

@end

@implementation SDWebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self mapTable_dictionary2];
}

/**-----SDWebImage显示图片
 UIKit的分类提供入口 供外部使用
 DownLoader下载模块 负责从网络下载
 Cache缓存模块 负责内存缓存和磁盘缓存
 Coder编解码模块 负责编解码 
 -----*/

/**-----NSMapTable 与 NSDictionary
 mapTable拥有更多的内存语义 而dictionary的key值必须遵循NSCopying协议-----*/

- (void)mapTable_dictionary{
    
    NSMutableDictionary *dictionary =[NSMutableDictionary dictionary];
    
    SDWebImagePerson *key = [SDWebImagePerson new];
    
    [dictionary setObject:self forKey:key];
    
    
    NSMapTable *mapTable =[[NSMapTable alloc]initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
    
    SDWebImagePerson *key2 = [SDWebImagePerson new];
    
    [mapTable setObject:self forKey:key2];
    
}

/**-----NSMapTable 与 NSDictionary
 这里的dictionary的key值必须遵循NSCopying协议 而SD……Person中copyWithZone：的实现是创建了一个新的Person 所以key肯定不是一个
 而mapTable的key的内存option设置的是Strong 所以key是一个 会覆盖 -----*/
- (void)mapTable_dictionary2{
    
    NSMutableDictionary *dictionary =[NSMutableDictionary dictionary];
    
    SDWebImagePerson *key = [SDWebImagePerson new];
    
    [dictionary setObject:@"1" forKey:key];
    
    [dictionary setObject:@"2" forKey:key];

    
    NSMapTable *mapTable =[[NSMapTable alloc]initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
    
    SDWebImagePerson *key2 = [SDWebImagePerson new];
    
    [mapTable setObject:@"1" forKey:key2];
    
    [mapTable setObject:@"2" forKey:key2];
    
    NSLog(@"%ld=dic.count,%ld=map.count",(long)dictionary.count,(long)mapTable.count);

}
@end
