//
//  MemoryMonitor.m
//  Aspects
//
//  Created by 神州第一坑 on 2021/4/20.
//

#import "MemoryMonitor.h"
#include <mach/mach.h>
@implementation MemoryMonitor

uint64_t memoryUsage() {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (result != KERN_SUCCESS)
        return 0;
    return vmInfo.phys_footprint;
}
@end
