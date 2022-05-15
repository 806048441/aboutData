//
//  LeetCode.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/5/7.
//

import Foundation

//26. 删除有序数组中的重复项
class Solution_26 {
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {

        var slow = 0
        var fast = 0
        
        while fast < nums.count {
            
            if nums[slow] != nums[fast] {
                
                slow+=1
                nums[slow] = nums[fast]
            }
            fast += 1
        }
        return slow + 1
    }
}
