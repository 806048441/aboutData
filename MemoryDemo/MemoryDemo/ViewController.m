//
//  ViewController.m
//  MemoryDemo
//
//  Created by 神州第一坑 on 2022/6/23.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CFRunLoopRef myCFRunLoop = CFRunLoopGetCurrent();
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"observer: loop entry");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"observer: before timers");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"observer: before sources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"observer: before waiting");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"observer: after waiting");
                break;
            case kCFRunLoopExit:
                NSLog(@"observer: exit");
                break;
            case kCFRunLoopAllActivities:
                NSLog(@"observer: all activities");
                break;
            default:
                break;
        }
    });
    CFRunLoopAddObserver(myCFRunLoop, observer, kCFRunLoopDefaultMode);
   
    
//    NSThread *thread = [[NSThread alloc]initWithBlock:^{
//       
//        CFRunLoopRef myCFRunLoop = CFRunLoopGetCurrent();
//        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//            switch (activity) {
//                case kCFRunLoopEntry:
//                    NSLog(@"observer: loop entry");
//                    break;
//                case kCFRunLoopBeforeTimers:
//                    NSLog(@"observer: before timers");
//                    break;
//                case kCFRunLoopBeforeSources:
//                    NSLog(@"observer: before sources");
//                    break;
//                case kCFRunLoopBeforeWaiting:
//                    NSLog(@"observer: before waiting");
//                    break;
//                case kCFRunLoopAfterWaiting:
//                    NSLog(@"observer: after waiting");
//                    break;
//                case kCFRunLoopExit:
//                    NSLog(@"observer: exit");
//                    break;
//                case kCFRunLoopAllActivities:
//                    NSLog(@"observer: all activities");
//                    break;
//                default:
//                    break;
//            }
//        });
//        CFRunLoopAddObserver(myCFRunLoop, observer, kCFRunLoopDefaultMode);
//        for (int i = 0; i < 1000000; i++) {
//            
//            Person *obj = [[Person alloc]init];
//        }
//    }];
//    
//    [thread start];
}


@end
