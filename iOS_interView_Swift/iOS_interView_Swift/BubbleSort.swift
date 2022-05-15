//
//  Sort.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/8.
//

import UIKit

class BubbleSort {
    
    /**-----冒泡排序 912题超时-----*/
    static func bubbleSort1(_ nums: [Int]) -> [Int] {
        
        if nums.count < 2 {
            
            return nums
        }
        
        var opNums = nums
        for endIndex in (1...opNums.count-1).reversed() {//终止位置 第一轮最后一位 第二轮倒数第二位 以此类推

            for beginIndex in 1...endIndex {//逻辑代码 从第0位开始 依次对比相邻两个元素 如果后者 比前者大则交换位置

                if opNums[beginIndex] < opNums[beginIndex-1] {

                    let tmp = opNums[beginIndex]
                    opNums[beginIndex] = opNums[beginIndex-1]
                    opNums[beginIndex-1] = tmp
                }
            }
        }
        return opNums
    }
    
    static func bubbleSort2(_ nums: [Int]) -> [Int] {
        
        var opNums = nums
        for endIndex in (1...opNums.count-1).reversed() {//终止位置 第一轮最后一位 第二轮倒数第二位 以此类推
            
            var flag = true //假设源数据已经完全有序
            for beginIndex in 1...endIndex {//逻辑代码 从第0位开始 依次对比相邻两个元素 如果后者 比前者大则交换位置
                
                if opNums[beginIndex] < opNums[beginIndex-1] {
                    
                    flag = false //有交换操作说明源数据并不是完全有序
                    let tmp = opNums[beginIndex]
                    opNums[beginIndex] = opNums[beginIndex-1]
                    opNums[beginIndex-1] = tmp
                }
            }
            
            if flag {//如果已经完全有序 则跳出排序
                
                break
            }
        }
        return opNums
    }
    
    static func bubbleSort3(_ nums: [Int]) -> [Int] {
        
        var opNums = nums
        
        var endIndex = opNums.count - 1
        //这里写成while循环是因为 for的index是let 不能赋值改变 swift还不精通
        while endIndex >= 1 { //终止位置 第一轮最后一位 第二轮倒数第二位 以此类推
            
            var sortIndex = 1 //这里设置成1 假如终止位置一直没有被赋值 说明完全有序 endIndex赋值-=1后 变为0 可以直接跳出循环 类似于优化1的flag
            for beginIndex in 1...endIndex {//逻辑代码 从第0位开始 依次对比相邻两个元素 如果后者 比前者大则交换位置
                
                if opNums[beginIndex] < opNums[beginIndex-1] {
                    
                    let tmp = opNums[beginIndex]
                    opNums[beginIndex] = opNums[beginIndex-1]
                    opNums[beginIndex-1] = tmp
                    //进行下一轮循环的时候 终止位置 是最后一次交换的位置 后边没交换说明后边已经有序。那么beginIndex就是下一轮冒泡的终止位置-1
                    sortIndex = beginIndex
                }
            }
            endIndex = sortIndex
            endIndex -= 1
         
        }
        return opNums
    }
    
    
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        
        var left = 0
        var right = nums.count - 1
        var mid = (right+left)>>1
        
        while left <= right && nums[mid] > nums[0] {
            
            mid = (right-left)>>1 + left
            if nums[mid] == target {
                
                return mid
            }
            if nums[mid] > nums[0] {
                
                mid = right + 1
            }
        }
       
        return -1
    }
}
