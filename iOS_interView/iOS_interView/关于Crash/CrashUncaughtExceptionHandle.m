//
//  CrashUncaughtExceptionHandle.m
//  iOS_interView
//
//  Created by 神州第一坑 on 2022/3/21.
//

#import "CrashUncaughtExceptionHandle.h"
#import "LXDBacktraceLogger.h"

int backtrace(void**,int) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);
char** backtrace_symbols(void* const*,int) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

@implementation CrashUncaughtExceptionHandle

+ (void)start{
    
    registerSignalHandler();
}

void UncaughtExceptionHandler(NSException * exception) {
    
    NSArray * arr = [exception callStackSymbols];
    NSString * reason = [exception reason]; // // 崩溃的原因  可以有崩溃的原因(数组越界,字典nil,调用未知方法...) 崩溃的控制器以及方法
    NSString * name = [exception name];
    
//    NSString *info = [LXDBacktraceLogger lxd_backtraceOfCurrentThread];
//    NSLog(@"||||name=%@\n||||nreason=%@\n||||info=%@",name,reason,info);
//    NSString *doucument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
//    NSString * path = [doucument stringByAppendingPathComponent:@"crash.txt"];
//    // 将一个txt文件写入沙盒
//    [info writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
 }


void registerSignalHandler(void) {
    
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    signal(SIGSEGV, handleSignalException);
    signal(SIGFPE, handleSignalException);
    signal(SIGBUS, handleSignalException);
    signal(SIGPIPE, handleSignalException);
    signal(SIGHUP, handleSignalException);
    signal(SIGINT, handleSignalException);
    signal(SIGQUIT, handleSignalException);
    signal(SIGABRT, handleSignalException);
    signal(SIGILL, handleSignalException);
}

void handleSignalException(int signal) {
    
    NSMutableString *crashString = [[NSMutableString alloc]init];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** traceChar = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; ++i) {
        [crashString appendFormat:@"%s\n", traceChar[i]];
    }
    NSLog(crashString);
}
@end
