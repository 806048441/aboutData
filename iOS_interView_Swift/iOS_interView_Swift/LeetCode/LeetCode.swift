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

//LCP 06. 拿硬币

class Solution_06 {
    
    func minCount(_ coins: [Int]) -> Int {
        
        var minTimes = 0
        for coin in coins {
            
            var times = coin/2
            if coin%2 > 0 {
                
                times += 1
            }
            minTimes += times
        }
        return minTimes
    }
}

