//
//  DataPersistenceViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/10.
//

#import "DataPersistenceViewController.h"
#import "PersistencePerson.h"
#import "sqlite3.h"
#import "FMDBManager.h"
@interface DataPersistenceViewController ()

@end


@implementation DataPersistenceViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self test4];
}

- (void)test1{
        
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"data"];
    
    NSArray *array = @[@"1",@"2",@"3",@"4"];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"array"];
    
    NSMutableArray * array2 = [NSMutableArray array];
    for (int i =0; i<10; i++) {
     
        PersistencePerson *person = [[PersistencePerson alloc]init];
        person.age = i;
        person.name = [@"name" stringByAppendingString:@(i).stringValue];
        [array2 addObject:person];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:array2 forKey:@"personArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSLog(@"%@",NSHomeDirectory());
}

- (void)test2{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *file = [path stringByAppendingPathComponent:@"data.dat"];
    NSMutableArray * array2 = [NSMutableArray array];
    for (int i =0; i<10; i++) {
     
        PersistencePerson *person = [[PersistencePerson alloc]init];
        person.age = i;
        person.name = [@"name" stringByAppendingString:@(i).stringValue];
        [array2 addObject:person];
    }
    
    [NSKeyedArchiver archiveRootObject:array2 toFile:file];
    NSLog(@"%@",file);
    
    NSArray *getArray = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    NSLog(@"%@",getArray);
}

- (void)test3{
    
    if (![FMDBManager sharedInstance].db.isOpen) {
        
        BOOL result =  [[FMDBManager sharedInstance].db open];
        if (!result) {
            
            return;
        }else{
            
            BOOL success = [[FMDBManager sharedInstance].db executeUpdate:@"CREATE TABLE IF NOT EXISTS personTable (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER DEFAULT 1 , nickName TEXT)"];
            
            if (success) {
                NSLog(@"创建表成功");
            } else {
                NSLog(@"创建表失败");
                return;
            }
        }
    }
    for (int i =0; i<10; i++) {
     
        PersistencePerson *person = [[PersistencePerson alloc]init];
        person.age = i*20;
        person.name = [@"name" stringByAppendingString:@(i).stringValue];
        person.nickName = [@"nickName" stringByAppendingString:@(i).stringValue];
        [[FMDBManager sharedInstance].db executeUpdateWithFormat:@"insert into personTable(name,nickName,age) values(%@,%@,%@)",person.name,person.nickName,@(person.age).stringValue];
    }
    
    FMResultSet *set = [[FMDBManager sharedInstance].db executeQueryWithFormat:@"SELECT *FROM personTable WHERE age > 30"];

    while ([set next]) {
        NSString *name = [set stringForColumnIndex:0];
        NSString *nickName = [set stringForColumnIndex:1];
        NSString *age = [set stringForColumnIndex:2];
        NSLog(@"%@ %@ %@",name,nickName,age);
    }
    
    [[FMDBManager sharedInstance].db executeUpdateWithFormat:@"DELETE FROM personTable"];
}

- (void)test4{
    
    if (![FMDBManager sharedInstance].db.isOpen) {
        
        BOOL result =  [[FMDBManager sharedInstance].db open];
        if (!result) {
            
            return;
        }else{
            
            BOOL success = [[FMDBManager sharedInstance].db executeUpdate:@"CREATE TABLE IF NOT EXISTS personTable (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER DEFAULT 1 , nickName TEXT)"];
            
            if (success) {
                NSLog(@"创建表成功");
            } else {
                NSLog(@"创建表失败");
                return;
            }
        }
    }
    
    [[FMDBManager sharedInstance].db beginTransaction];
    BOOL isRollBack = NO;
    
    for (int i=0; i<100; i++) {
        
        PersistencePerson *person = [[PersistencePerson alloc]init];
        person.age = i*20;
        person.name = [@"name" stringByAppendingString:@(i).stringValue];
        person.nickName = [@"nickName" stringByAppendingString:@(i).stringValue];
        if (i>90) {
            isRollBack = YES;
            break;
        }
        BOOL su = [[FMDBManager sharedInstance].db executeUpdateWithFormat:@"insert into personTable(name,nickName,age) values(%@,%@,%@)",person.name,person.nickName,@(person.age).stringValue];
        if (!su) {
            
            isRollBack = YES;
            break;
        }
    }
    if (isRollBack) {
        
        [[FMDBManager sharedInstance].db rollback];
    }else{
        
        [[FMDBManager sharedInstance].db commit];
    }
}
@end
