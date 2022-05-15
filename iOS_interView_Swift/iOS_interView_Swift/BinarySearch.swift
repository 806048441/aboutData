//
//  BinarySearch.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/2/18.
//

import UIKit

class BinarySearch: NSObject {
    
    func firstBadVersion(_ n: Int) -> Int {
            
        var left = 1
        var right = n
        var mid = (left+right)>>1
        while isBadVersion(mid) {
            
            mid = ((right + left)>>1)-left
            if mid <= right {
                
                right = mid - 1
            }else{
                
                left = mid + 1
            }
        }
        
        while isBadVersion(mid) == false{
            
            mid = mid + 1
        }
        return mid
    }
    
    func isBadVersion(_ version:Int) -> Bool {
        
        return version >= 4
    }
    
    func search(_ nums: [Int], _ target: Int) -> Int {

        var left = 0
        var right = nums.count - 1
        var mid = (left + right)/2
        var last:Int = -1
        
        while left <= right {
            
            mid = ((right-left) >> 1) + left
            if target == nums[mid]{
                
                last = mid
                break
            }else if target < nums[mid]{
             
                right = mid - 1
            }else{
                
                left = mid + 1
            }
        }
        return last
    }
    
//    33. 搜索旋转排序数组
    func search2(_ nums: [Int], _ target: Int) -> Int {
        
        var begin = 0
        var end = nums.count
        while begin < end {
            
            var mid = (begin + end) >> 1
            if target == nums[mid] {
                
                return mid
            }else if (nums[mid] > nums[0]){
                
                if target > nums[0] && target < nums[mid] {
                    
                    end = mid - 1
                }else{
                    
                    begin = mid + 1
                }
            }else{
                
                
            }
        }
        
        return -1
    }
    
    
}
