//
//  MemeoryViewController.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/12/1.
//

#import "MemeoryViewController.h"
#import "MemoryTimerTarget.h"
#import "MemoryTimerProxy.h"
int age =10;
int age2;

extern void _objc_autoreleasePoolPrint(void);

@interface MemeoryViewController ()

@property (strong,nonatomic)NSString *taggedQName;
@property (strong,nonatomic)NSTimer *timer;
@property (strong,nonatomic)MemoryTimerTarget *timerTaget;
@property (strong,nonatomic)MemoryTimerProxy *timerTaget2;
@end

@implementation MemeoryViewController
- (void)dealloc {
    
    if (_timer) {
        [_timer invalidate];
        _timer =nil;
    }
    NSLog(@"---%s----",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self checkObjReleaseTime];
    
//    __weak id a;
//    @autoreleasepool {
        

//            a = [NSNumber numberWithLongLong:131323123123123190];
//        a = @{@"1":@"1",@"2":@"2"};
//    }
    
//    NSLog(@"%@",a);
//    NSDictionary *dic =@{@"1":@"1"};
//    NSNumber *num = [NSNumber numberWithInteger:NSIntegerMax];
//    NSNumber *num2 = @(NSIntegerMax);
//    NSLog(@"%d  %d  %d",_objc_isTaggedPointer((__bridge const void * _Nullable)(num)),_objc_isTaggedPointer((__bridge const void * _Nullable)(num2)),_objc_isTaggedPointer((__bridge const void * _Nullable)(dic)));
//    NSLog(@"%p %p",num,num2);
//    UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
//    [self.view addSubview:textView];
//    textView.text =@"UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];[self.view addSubview:textView];UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];[self.view addSubview:textView];UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];[self.view addSubview:textView];UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];[self.view addSubview:textView];";
//
//    [self checkMemeoryAddress];
//    [self taggedPointerQ_01];
//    [self taggedPointerQ_02];
//    [self timer_01];
//    [self memoryBig_01];
//    [self memoryBig_02];

}

/**-----地址分配 从低到高 保留区 代码区 data区 堆区 栈区
 代码区 存放代码
 data区 字符串常量 已初始化的全局变量 静态变量 未初始化的全局变量 静态变量 分配内存是连续的
 堆区  alloc copy new 等变量
 栈 局部变量 栈空间是从高到底分配内存的 分配内存也是连续的
 -----*/
//0x10f0bc908==str字符串常量,
//0x10f0c26dc==age已初始化全局变量
//0x10f0c26e0==age3已初始化静态变量
//0x10f0c27b8==age2未初始化全句变量
//0x10f0c27bc==age4未初始化静态变量
//0x600003184390==obj对象
//0x7ffee0b49bbc==age5已初始化局部变量
//0x7ffee0b49bb8==age6未初始化局部变量

- (void)checkMemeoryAddress{
    
    NSString *str =@"abc";
    
    static int age3 =10;
    
    static int age4;
    
    NSObject *obj =[NSObject new];
    
    int age5 =10;
    
    int age6;
    
    NSLog(@"%p==str字符串常量,%p==age已初始化全局变量\n%p==age3已初始化静态变量\n%p==age2未初始化全句变量\n%p==age4未初始化静态变量\n%p==obj对象\n%p==age5已初始化局部变量\n%p==age6未初始化局部变量",str,&age,&age3,&age2,&age4,obj,&age5,&age6);
}

#if __arm64__
// ARM64 uses a new tagged pointer scheme where normal tags are in
// the low bits, extended tags are in the high bits, and half of the
// extended tag space is reserved for unobfuscated payloads.
#   define OBJC_SPLIT_TAGGED_POINTERS 1
#else
#   define OBJC_SPLIT_TAGGED_POINTERS 0
#endif

#if (TARGET_OS_OSX || TARGET_OS_MACCATALYST) && __x86_64__
    // 64-bit Mac - tag bit is LSB
#   define OBJC_MSB_TAGGED_POINTERS 0
#else
    // Everything else - tag bit is MSB
#   define OBJC_MSB_TAGGED_POINTERS 1
#endif

#if OBJC_SPLIT_TAGGED_POINTERS
#   define _OBJC_TAG_MASK (1UL<<63)
#elif OBJC_MSB_TAGGED_POINTERS
#   define _OBJC_TAG_MASK (1UL<<63)
#else
#   define _OBJC_TAG_MASK 1UL
#endif
/**-----源码中判断是否是taggedPointer指针方法-----*/
static inline bool
_objc_isTaggedPointer(const void * _Nullable ptr)
{
    NSLog(@"%ld",_OBJC_TAG_MASK);
    return ((uintptr_t)ptr & _OBJC_TAG_MASK) == _OBJC_TAG_MASK;
}

/**-----关于TaggedPointer
 从64bit之后引用taggedPointer技术 用来存放轻量级的对象 包括NSString NSNumber NSDate等
 本来都是OC对象 动态分配内存 维护引用计数；使用这种技术后，轻量级的对象储存内容变为Tag+Data 讲数据直接储存在指针中，ObjC_msgSend能识别TaggedPointer。指针直接存放内容 这种轻量级对象就节省内存开销
 -----*/
- (void)taggedPointerQ_01{
    
    //    这种不会有问题 taggedPointer指针 并没有调用setter
    dispatch_queue_t queue =dispatch_get_global_queue(0, 0);
    for (int i =0; i<1000; i++) {
    
        dispatch_async(queue, ^{
           
            self.taggedQName = [NSString stringWithFormat:@"%d 123",i];
            NSLog(@"%d>>>>",_objc_isTaggedPointer((__bridge const void * _Nullable)(self.taggedQName)));
        });
    }
}

- (void)taggedPointerQ_02{
    
//    这种会产生安全问题 多个线程同时调用某方法setter方法 setter内部实现是 先release原来的 再retain现在的赋值 当release后 另一个线程再去调用 会再release release一个不存在的 会崩溃内存访问
    
    dispatch_queue_t queue =dispatch_get_global_queue(0, 0);
    for (int i =0; i<1000; i++) {
        
        dispatch_async(queue, ^{
           
            self.taggedQName = [NSString stringWithFormat:@"%d abcdedfghijk",i];
            NSLog(@"%d>>>>",_objc_isTaggedPointer((__bridge const void * _Nullable)(self.taggedQName)));
        });
    }
}

/**-----
 使用CADisplayLink、NSTimer有什么注意点？
 -----*/
- (void)timer_01{
    
    /**-----
     timer用strong修饰 视图控制器对timer有一个强引用 target：self 说明timer对self有一个强引用 所以导致在delloc释放 会释放不掉 解决方法1：用block计时器 解决方法2：消息转发 CADisplayLink也是类似的-----*/
//    self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
//    //从GNU源码中看的话 scheduled方法 默认计时器timer添加到defalutMode textView试过了
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self.timer fire];
    
    /**-----解决方法1-----*/
//    __weak typeof(self) weakSelf =self;
//    self.timer= [NSTimer scheduledTimerWithTimeInterval:1 repeats:1 block:^(NSTimer * _Nonnull timer) {
//
//        [weakSelf timerMethod];
//    }];
//
    /**-----解决方法2-----*/
//    self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self.timerTaget selector:@selector(timerMethod) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self.timer fire];

    /**-----OC中有一个专门处理消息转发的类NSProxy-----*/
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self.timerTaget2 selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

- (MemoryTimerTarget *)timerTaget{
    
    if (!_timerTaget) {
        
        _timerTaget =[[MemoryTimerTarget alloc]init];
        _timerTaget.target = self;
    }
    return _timerTaget;
}

- (MemoryTimerProxy *)timerTaget2{
    
    if (!_timerTaget2) {
        
        _timerTaget2 =[MemoryTimerProxy alloc];
        _timerTaget2.target=self;
    }
    return _timerTaget2;
}

- (void)timerMethod{
    
    NSLog(@"%s",__func__);
}

/**-----对内存管理的了解？
 才用引用计数管理内存 谁创建谁释放 谁引用谁管理
 alloc  new copy retain 引用计数+1 release引用计数减1 引用计数为0时 释放-----*/
 
/**-----copy和mutableCopy 无论是copy还是mutableCopy 目的都是copy一份原来的 新旧改变互不影响;之所以有浅拷贝是因为浅拷贝之前是不可变对象 浅拷贝之后还是不可变对象，因为不可变，所以没有改变，用不着去深拷贝一份 重新占用内存空间，直接指针拷贝就行
 NSString copy 生成NSString 指针拷贝 浅拷贝
 NSString muCopy 生成NSMutableString 深拷贝
 NSArray copy 生成NSArray 指针拷贝 浅拷贝
 NSArray muCopy 生成NSMutableArray 深拷贝
 NSDictionary copy 生成NSDictionary 指针拷贝 浅拷贝
 NSDictionary muCopy 生成NSMutableDictionary 深拷贝
 NSMutableString copy 生成NSMutableString 深拷贝
 NSMutableString muCopy 生成NSMutableString 深拷贝
 NSMutableArray copy 生成NSMutableArray 深拷贝
 NSMutableArray muCopy 生成NSMutableArray 深拷贝
 NSMutableDictionary copy 生成NSMutableDictionary 深拷贝
 NSMutableDictionary muCopy 生成NSMutableDictionary 深拷贝
 -----*/

/**-----关于isa和引用计数的储存 这里只从源码贴一个64位架构下的 -----*/
//union isa{
//    uintptr_t nonpointer        : 1; //占1位 存是否是优化过的指针 0代表普通指针 1代表优化过isa
//    uintptr_t has_assoc         : 1;//占1 是否有过关联对象 如果没有关联过 释放会更快
//    uintptr_t has_cxx_dtor      : 1;//占1位 是否有c++析构函数
//    uintptr_t shiftcls          : 33;//这33位 存isa指向的 类对象 或者元类对象地址
//    uintptr_t magic             : 6;
//    uintptr_t weakly_referenced : 1;//是否被弱引用过
//    uintptr_t unused            : 1;
//    uintptr_t has_sidetable_rc  : 1;//是否有引用计数表
//    uintptr_t extra_rc          : 19;//引用计数 如果这19位够存引用计数 则散列表不存该对象的引用计数 如果不够存has_sidetable_rc里会存1 这样该对象的引用计数会存在散列表里
//};


//struct SideTable {
//    spinlock_t slock;//自旋锁
//    RefcountMap refcnts; //哈希表 key是对象的内存地址 value是对象的引用计数
//    weak_table_t weak_table;//弱引用表 哈希表 储存着所有有弱引用关系的所有对象等信息
//
//    SideTable() {
//        memset(&weak_table, 0, sizeof(weak_table));
//    }
//
//    ~SideTable() {
//        _objc_fatal("Do not delete SideTable.");
//    }
//
//    void lock() { slock.lock(); }
//    void unlock() { slock.unlock(); }
//    void forceReset() { slock.forceReset(); }
//
//    // Address-ordered lock discipline for a pair of side tables.
//
//    template<HaveOld, HaveNew>
//    static void lockTwo(SideTable *lock1, SideTable *lock2);
//    template<HaveOld, HaveNew>
//    static void unlockTwo(SideTable *lock1, SideTable *lock2);
//};

//typedef objc::DenseMap<DisguisedPtr<objc_object>,size_t,RefcountMapValuePurgeable> RefcountMap;
//根据对象的内存地址  可以从sideTable中的refcnts 中取出来对应引用计数值 哈希表


//struct weak_table_t {
//    weak_entry_t *weak_entries; //哈希表 某对象内存地址当key 可以取出或者存入 对key对应对象有弱引用的所有对象，也就是value是对key对应对象有弱引用的所有对象
//    size_t    num_entries;
//    uintptr_t mask;
//    uintptr_t max_hash_displacement;
//};

//struct weak_entry_t {
//    DisguisedPtr<objc_object> referent;//哈希表 某对象内存地址当key value是key对应对象的弱引用信息
//    union {
//        struct {
//            weak_referrer_t *referrers;
//            uintptr_t        out_of_line_ness : 2;
//            uintptr_t        num_refs : PTR_MINUS_2;
//            uintptr_t        mask;
//            uintptr_t        max_hash_displacement;
//        };
//        struct {
//            // out_of_line_ness field is low bits of inline_referrers[1]
//            weak_referrer_t  inline_referrers[WEAK_INLINE_COUNT];
//        };
//    };
//
//    bool out_of_line() {
//        return (out_of_line_ness == REFERRERS_OUT_OF_LINE);
//    }
//
//    weak_entry_t& operator=(const weak_entry_t& other) {
//        memcpy(this, &other, sizeof(other));
//        return *this;
//    }
//
//    weak_entry_t(objc_object *newReferent, objc_object **newReferrer)
//        : referent(newReferent)
//    {
//        inline_referrers[0] = newReferrer;
//        for (int i = 1; i < WEAK_INLINE_COUNT; i++) {
//            inline_referrers[i] = nil;
//        }
//    }
//};

/**-----内存管理中的weak弱引用是由runtime在运行时完成的 和release copy alloc new retain操作有点不太一样，这些是通过lvmm编译器完成的-----*/

/**-----关于自动释放池
 __AtAutoreleasePool、AutoreleasePoolPage 底层的主要数据结构
 AutoreleasePoolPage是一个双向链表 从底层源码也可以看出来 主要内容有     friend struct thread_data_t; 内部有一个对应的线程 *next 下一个存放autoRelease对象的内存地址 #   define POOL_BOUNDARY nil POOL_BOUNDARY是边界 开始往池里添加东西的时候 会先把这个push进去 当pop的时候 把这个地址传进去 pop到此说明 此次pop已经完成 parent child 分别指向双向链表的上一节和下一节
 主线程的runLoop注册了两个observe 第一个是进入runloop的时候 loopEntry 会调用AutoreleasePoolPage的push  第二个是监听了runloop的beforeWait、调用AutoreleasePoolPage的pop 然后又push；exit 调用AutoreleasePoolPage的pop-----*/

//static inline void *push()
//{
//    id *dest;
//    if (slowpath(DebugPoolAllocation)) {
//        // Each autorelease pool starts on a new pool page.
//        dest = autoreleaseNewPage(POOL_BOUNDARY);
//    } else {
//        dest = autoreleaseFast(POOL_BOUNDARY);
//    }
//    ASSERT(dest == EMPTY_POOL_PLACEHOLDER || *dest == POOL_BOUNDARY);
//    return dest;
//}

//static inline void
//pop(void *token)
//{
//    AutoreleasePoolPage *page;
//    id *stop;
//    if (token == (void*)EMPTY_POOL_PLACEHOLDER) {
//        // Popping the top-level placeholder pool.
//        page = hotPage();
//        if (!page) {
//            // Pool was never used. Clear the placeholder.
//            return setHotPage(nil);
//        }
//        // Pool was used. Pop its contents normally.
//        // Pool pages remain allocated for re-use as usual.
//        page = coldPage();
//        token = page->begin();
//    } else {
//        page = pageForPointer(token);
//    }
//
//    stop = (id *)token;
//    if (*stop != POOL_BOUNDARY) {
//        if (stop == page->begin()  &&  !page->parent) {
//            // Start of coldest page may correctly not be POOL_BOUNDARY:
//            // 1. top-level pool is popped, leaving the cold page in place
//            // 2. an object is autoreleased with no pool
//        } else {
//            // Error. For bincompat purposes this is not
//            // fatal in executables built with old SDKs.
//            return badPop(token);
//        }
//    }
//
//    if (slowpath(PrintPoolHiwat || DebugPoolAllocation || DebugMissingPools)) {
//        return popPageDebug(token, page, stop);
//    }
//
//    return popPage<false>(token, page, stop);
//}

/**-----关于delloc方法做了什么-----*/

//inline void
//objc_object::rootDealloc()
//{
//    if (isTaggedPointer()) return;  // fixme necessary?
//
//    if (fastpath(isa.nonpointer                     &&
//                 !isa.weakly_referenced             &&
//                 !isa.has_assoc                     &&
//#if ISA_HAS_CXX_DTOR_BIT
//                 !isa.has_cxx_dtor                  &&
//#else
//                 !isa.getClass(false)->hasCxxDtor() &&
//#endif
//                 !isa.has_sidetable_rc))
//    {
//        assert(!sidetable_present());
//        free(this);
//    }
//    else {
//        object_dispose((id)this);
//    }
//}

//id
//object_dispose(id obj)
//{
//    if (!obj) return nil;
//
//    objc_destructInstance(obj);
//    free(obj);
//
//    return nil;
//}

//void *objc_destructInstance(id obj)
//{
//    if (obj) {
//        // Read all of the flags at once for performance.
//        bool cxx = obj->hasCxxDtor();
//        bool assoc = obj->hasAssociatedObjects();
//
//        // This order is important.
//        if (cxx) object_cxxDestruct(obj);
//        if (assoc) _object_remove_assocations(obj, /*deallocating*/true);
//        obj->clearDeallocating();
//    }
//
//    return obj;
//}

- (void)memoryBig_01{
    
 
    /**-----这种情况内存并不会暴增 并且后边新创建的对象地址和前边有的一样 说明前边的对象已经被释放了-----*/
    for (int i =0; i<10000000; i++) {
        
        MemoryTimerTarget *target =[[MemoryTimerTarget alloc]init];
        NSLog(@"%p=target的指针地址",target);
    }
}

- (void)memoryBig_02{
    
 
    NSOperationQueue *queue =[NSOperationQueue mainQueue];
    NSOperation *op =[[NSBlockOperation alloc]init];
    /**-----这种情况内存会暴增-----*/
    for (int i =0; i<10000000; i++) {
        
        NSString *string =[NSString stringWithFormat:@"opfadlfajdflajfljdasfljasldfjlasdjflsjf"];
        NSLog(@"%p=target的指针地址",string);
    }
}

- (void)checkObjReleaseTime{
    
    _objc_autoreleasePoolPrint();


    CFRunLoopObserverRef observe = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observe, kCFRunLoopCommonModes);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        Class cls = NSClassFromString(@"RuntimePerson");
        id obj = [[cls alloc]init];
        
        NSLog(@"%p>>>",obj);
        _objc_autoreleasePoolPrint();

    });
}
@end
