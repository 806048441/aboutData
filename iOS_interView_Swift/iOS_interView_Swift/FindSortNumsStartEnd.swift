//
//  FindSortNumsStartEnd.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/8.
//

import Foundation

class FindSortNumsStartEnd_Solution {
    
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        
        var left = 0
        var right = nums.count - 1
        var index = -1
        var mid = (left + right)>>1
        while left < right {
            
            mid = (right - left)>>1 + left
            if nums[mid] == target {
                
                index = mid
                break
            }else if (target > nums[mid]) {
                
                left = mid + 1
            }else{
                
                right = mid - 1
            }
        }
        if index == -1 {
            
            return [-1,-1]
        }
        
        var start = index
        while start >= 0 && nums[start] == target {
            
            start = start - 1
        }
        
        var end = index
        while end <= nums.count-1 && nums[end] == target {
            
            end = end + 1
        }
        
        return [start+1,end-1]
    }
}




