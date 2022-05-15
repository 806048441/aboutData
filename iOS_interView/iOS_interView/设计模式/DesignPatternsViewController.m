//
//  DesignPatternsViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/2/23.
//

#import "DesignPatternsViewController.h"
#import <Photos/Photos.h>
#import <objc/runtime.h>
#import "LearningMaterialCell.h"

@interface DesignPatternsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSArray *learningMaterials;
@property (strong,nonatomic)NSArray *learningViewControllers;

@end

@implementation DesignPatternsViewController

/**-----单一原则，开闭原则，依赖倒置原则，接口分离原则，里氏替换原则原则，迪米特法则-----*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"设计模式";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
//    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//
//    unsigned count = 0;
//    Ivar *ivarList = class_copyIvarList(PHPhotoLibrary.class, &count);
//
//    for (int i = 0; i<count; i++) {
//
//        Ivar ivar = ivarList[i];
//        NSLog(@"%s>>%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
//    }
//
//    NSBundle*b;
//
//    NSURL *url = [[PHPhotoLibrary sharedPhotoLibrary] valueForKey:@"_photoLibraryURL"];
//
//
//    NSLog(@"%@",url.absoluteString);
//    NSLog(@"%@>>>daxiao",folderSizeAtPath(url.absoluteString));
//        //将smartAlbums中的相册添加到数组中(最近添加，相机胶卷,视频...)
//        for (PHAssetCollection *collection in smartAlbums) {
//
//            //如果不想显示 ‘最近添加’ ‘收藏’等 可以这样做
//            if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumRecentlyAdded || collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumFavorites) {
//                continue;
//            }
//
//            //遍历所有相册，只显示有视频或照片的相册
//            PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
//            fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d || mediaType == %d", PHAssetMediaTypeImage,PHAssetMediaTypeVideo];
//
//            //按创建时间排序
//            fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//
//            PHFetchResult *assetResults = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
//            if (assetResults.count>0) {
////                [self.albumsArray addObject:collection];
//            }
//        }
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
        _myTableView.estimatedRowHeight=44;
        [_myTableView registerClass:[LearningMaterialCell class] forCellReuseIdentifier:@"LearningMaterialCell"];
    }
    return _myTableView;
}

- (NSArray *)learningMaterials{
    
    if (!_learningMaterials) {
        
        _learningMaterials = @[@"简单工厂",@"工厂方法",@"抽象工厂",@"策略模式",@"装饰模式"];
    }
    return _learningMaterials;
}

- (NSArray *)learningViewControllers{
    
    if (!_learningViewControllers) {
        
        _learningViewControllers =@[@"SimpleFactoryViewController",@"FactoryMethodViewController",@"AbstractFactoryViewController",@"StrategyViewController",@"DecoratorViewController"];
    }
    return _learningViewControllers;
}

#pragma mark - protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.learningMaterials.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LearningMaterialCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LearningMaterialCell"];
    cell.label.text=self.learningMaterials[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *classString =self.learningViewControllers[indexPath.row];
    UIViewController *viewController =[[NSClassFromString(classString) alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}


long long fileSizeAtPath(NSString* filePath){

    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

NSString *folderSizeAtPath(NSString* folderPath){
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
//    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += fileSizeAtPath(fileAbsolutePath);
    }
    return  sizeOfFile(folderSize);
}

NSString *sizeOfFile(long long folderSize){

    if (folderSize < 1024.0) {
        return  [NSString stringWithFormat:@"%.2fB",folderSize * 1.0];
    }else if (folderSize >= 1024.0 && folderSize < (1024.0*1024.0)){
        return  [NSString stringWithFormat:@"%.2fKB",folderSize/1024.0];
    }if (folderSize >= (1024.0*1024.0) && folderSize < (1024.0*1024.0*1024.0)) {
        return [NSString stringWithFormat:@"%.2fMB", folderSize/(1024.0*1024.0)];
    }else{
        return [NSString stringWithFormat:@"%.2fGB", folderSize/(1024.0*1024.0*1024.0)];
    }
}

@end
