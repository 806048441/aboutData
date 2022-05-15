//
//  main.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
void (^MainBlockHandle)(void);

void test(){
    
    int a = 10;
    MainBlockHandle =^{
        
        NSLog(@"%d=mainA",a);
    };
}

void getP() {
    
    double array[10];
    NSLog(@"%p",&array);
    for (int i = 0; i<sizeof(array)/sizeof(double); i++) {
        
        NSLog(@"%p",&array[i]);
    }
//    0x7ffee1b6bc80
//    0x7ffee1b6bc88
//    0x7ffee1b6bc90
//    0x7ffee1b6bc98
//    0x7ffee1b6bca0
//    0x7ffee1b6bca8
//    0x7ffee1b6bcb0
//    0x7ffee1b6bcb8
//    0x7ffee1b6bcc0
//    0x7ffee1b6bcc8
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
//        test();
//        MainBlockHandle();
        
        getP();
        appDelegateClassName = NSStringFromClass([AppDelegate class]);

    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
