//
//  SelectionSort.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/18.
//

import Foundation

class SelectionSort {
    
    /**-----选择排序-----*/
    static func selectionSort1(_ nums: [Int]) -> [Int] {
        
        if nums.count < 2 {
            
            return nums
        }
        
        //现在思路是从未排序的元素序列中拿出 放到已经排好序序列的后边
        
        var opNums = nums // 未进行排序的元素存放在这里
        var resultNums:[Int] = Array.init() //最后要返回的元素有序序列 也就是已经排好序元素都存放在这里
        while opNums.count > 0 {
            
            var minIndex = 0
            for index in 1..<opNums.count {//找到最小元素的下标
                
                if opNums[minIndex] > opNums[index] {
                    
                    minIndex = index
                }
            }
            //先添加 再删除 如果opNums先删除 当添加的时候 opNums的minIndex元素已经移除 会造成crash或者minIndex的元素已经不是最小的元素
            resultNums.append(opNums[minIndex])
            opNums.remove(at: minIndex) //
        }
        return resultNums
    }
    
    
    
    static func selectionSort2(_ nums: [Int]) -> [Int] {
        
        if nums.count < 2 {
            
            return nums
        }
        
        var compareTime = 0
        var swapTime = 0
        var modifyTime = 0
        //现在思路是从未排序的元素序列中拿出 放到已经排好序序列的后边
        var opNums = nums // 未进行排序的元素存放在这里
        
        for endIndex in (1..<opNums.count).reversed() { //代表遍历的终止位置，也是下边步骤找到最大元素后要交换的位置 已经排好序元素的起始位置下标-1 n，n-1,n-2,n-3…1
            
            var maxIndex = 0
            for startIndex in 1...endIndex { //一轮遍历 每次都先假设第0位为最大元素 依次次比较
                
                compareTime += 1
                if opNums[maxIndex] < opNums[startIndex] {
                    
                    maxIndex = startIndex
                    modifyTime += 1
                }
            }
            let tmp = opNums[endIndex]
            opNums[endIndex] = opNums[maxIndex]
            opNums[maxIndex] = tmp
            swapTime += 1
        }
        
        print("static func selectionSort2 compareTime = \(compareTime), swapTime = \(swapTime),modifyTime = \(modifyTime)")
        return opNums
    }
    
    static func selectionSort3(_ nums: [Int]) -> [Int] {
        
        if nums.count < 2 {
            
            return nums
        }
        
        var compareTime = 0
        var swapTime = 0
        var modifyTime = 0
        //现在思路是从未排序的元素序列中拿出 放到已经排好序序列的后边
        var opNums = nums // 未进行排序的元素存放在这里
        
        for startIndex in 0..<opNums.count-1 { //代表遍历起始位置 也是排好序元素的终止位置+1
            
            var minIndex = startIndex
            for index in startIndex+1...opNums.count-1 { //一轮遍历 每次都先假设第startIndex位为最小元素 依次次比较
                
                compareTime += 1
                if opNums[minIndex] > opNums[index] {
                    
                    minIndex = index
                    modifyTime += 1
                }
            }
            let tmp = opNums[startIndex]
            opNums[startIndex] = opNums[minIndex]
            opNums[minIndex] = tmp
            swapTime += 1
        }
        
        print("static func selectionSort3 compareTime = \(compareTime), swapTime = \(swapTime),modifyTime = \(modifyTime)")
        return opNums
    }
    
    /**static func selectionSort2 compareTime = 12497500, swapTime = 4999,modifyTime = 31520
     selectionSort2耗时：4.3031229972839355秒
     static func selectionSort3 compareTime = 12497500, swapTime = 4999,modifyTime = 34461
     selectionSort3耗时：4.470118045806885秒*/
    
    
}
