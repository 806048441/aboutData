//
//  CpuMonitor.m
//  Aspects
//
//  Created by 神州第一坑 on 2021/4/20.
//

#import "CpuMonitor.h"
#include <mach/mach.h>
@implementation CpuMonitor


//struct thread_basic_info {
//  time_value_t    user_time;     // 用户运行时长
//  time_value_t    system_time;   // 系统运行时长
//  integer_t       cpu_usage;     // CPU 使用率
//  policy_t        policy;        // 调度策略
//  integer_t       run_state;     // 运行状态
//  integer_t       flags;         // 各种标记
//  integer_t       suspend_count; // 暂停线程的计数
//  integer_t       sleep_time;    // 休眠的时间
//};

+ (integer_t)cpuUsage {
    
    thread_act_array_t threads; //int 组成的数组比如 thread[1] = 5635
    mach_msg_type_number_t threadCount = 0; //mach_msg_type_number_t 是 int 类型
    const task_t thisTask = mach_task_self(); //根据当前 task 获取所有线程
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    integer_t cpuUsage = 0;
    // 遍历所有线程
    for (int i = 0; i < threadCount; i++){
        thread_info_data_t threadInfo; thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        if (thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO,(thread_info_t)threadInfo, &threadInfoCount) == KERN_SUCCESS) {
            // 获取 CPU 使用率
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
                cpuUsage += threadBaseInfo->cpu_usage;
            }
        }
    }
    assert(vm_deallocate(mach_task_self(), (vm_address_t)threads, threadCount * sizeof(thread_t)) == KERN_SUCCESS);
    return cpuUsage;
}
@end
