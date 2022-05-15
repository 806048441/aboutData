//
//  CategoryPerson+Test.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/26.
//

#import "CategoryPerson+Test.h"

@implementation CategoryPerson (Test)

/**-----分类的底层结构-----*/
struct _category_t {
    const char *name;
    struct _class_t *cls;
    const struct _method_list_t *instance_methods;
    const struct _method_list_t *class_methods;
    const struct _protocol_list_t *protocols;
    const struct _prop_list_t *properties;
};

/**-----runtime加载过程
 源码解读顺序
 objc-os.mm
 _objc_init
 map_images
 map_images_nolock

 objc-runtime-new.mm
 _read_images
 remethodizeClass
 attachCategories
 attachLists
 realloc、memmove、 memcpy

 
 把所有Category的方法、属性、协议数据，合并到一个大数组中
 后面参与编译的Category数据，会在数组的前面

 将合并后的分类数据（方法、属性、协议），插入到类原来数据的前面
-----*/

- (void)categoryInstanceMethod{
    
}

+ (void)categoryClassMethod{
    
}

- (void)test{
    
    NSLog(@"%s",__func__);
}


@end
