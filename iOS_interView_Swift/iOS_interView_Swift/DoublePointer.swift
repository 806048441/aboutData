//
//  DoublePointer.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/2/19.
//

import UIKit

class DoublePointer {
    
    func searchInsertTarget(_ nums:inout [Int], _ target: Int) -> [Int] {
                
        var mid:Int = nums.count>>1
        var left:Int = 0
        var right:Int = nums.count-1
        var last:Int = nums.count
        while (left <= right) {
            mid = ((right - left) >> 1) + left;
            if (target <= nums[mid]) {
                last = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        nums.insert(target, at: last)
        return nums
    }
    
    func sortedSquares(_ nums: [Int]) -> [Int] {

//        var lastNums:[Int] = Array.init()
//        for num in nums {
//
//            lastNums = searchInsertTarget(&lastNums, num*num)
//        }
//
//        return lastNums
        
        var lastNums:[Int] = Array.init()
        var pointerIndex = -1
        for index in 0..<nums.count {
            
            if nums[index] < 0 {
                pointerIndex = index
            }else{
                break
            }
        }
        var i = pointerIndex
        var j = pointerIndex + 1
        while i>=0 || j<nums.count-1 {
            
            if i<0 {
                
                lastNums.append(nums[j]*nums[j])
                j+=1
            }else if (j==nums.count-1){
                
                lastNums.append(nums[i]*nums[i])
                i-=1
            }else if nums[i]*nums[i]>=nums[j]*nums[j] {
                
                lastNums.append(nums[i]*nums[i])
                i-=1
            }else{
            
                lastNums.append(nums[j]*nums[j])
                j+=1
            }
        }
        return lastNums
    }
    
    func rotate(_ nums: inout [Int], _ k: Int) {

        var lastNums:[Int] = Array.init()
        
        let startIndex = nums.count - k%nums.count
        
        for index in startIndex..<startIndex+nums.count {
            
            let num = nums[index%nums.count]
            lastNums.append(num)
        }
        nums = lastNums
    }
    
    func moveZeroes(_ nums: inout [Int]) {
        
        var index = nums.count - 1
        while index >= 0 {
            
            if nums[index]==0 {
                
                nums.remove(at: index)
                nums.append(0)
            }
            index -= 1
        }
    }
    
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {

        var indexs:[Int] = Array.init()
        for index in 0..<numbers.count {
            
            let otherNum = target - numbers[index]
            if numbers.contains(otherNum) {
                
                let index2 = numbers.lastIndex(of: otherNum)
                indexs = [index+1,index2!+1]
                break
            }
        }
        return indexs
    }
}
