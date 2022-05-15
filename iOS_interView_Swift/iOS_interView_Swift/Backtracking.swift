//
//  Backtracking.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/5/5.
//

import Foundation


//46. 全排列
class Solution_46 {
    
    var returnValue:[[Int]] = Array.init()
    func permute(_ nums: [Int]) -> [[Int]] {
        
        backtracking(nums,[])
        return returnValue
    }
    
    func backtracking(_ nums:[Int],_ hasSelectNums:[Int]) -> () {
        

        if hasSelectNums.count == nums.count {
            
            returnValue.append(hasSelectNums)
            return
        }
        
        for index in 0...nums.count-1 {
            
            let val = nums[index]
            if hasSelectNums.contains(val) {
                
                continue
            }
            var array = hasSelectNums
            array.append(val)
            backtracking(nums,array)
            array.removeLast()
        }
    }
}

//47. 全排列 II
class Solution_47 {
    
    var startValues:[Int] = Array.init()
    var returnValue:[[Int]] = Array.init()
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        
        backtracking(nums, [])
        return returnValue
    }
    
    func backtracking(_ nums:[Int],_ hasSelectIndexs:[Int]) -> () {
        
        if hasSelectIndexs.count == nums.count {
            
            var array:[Int] = Array.init()
            for hasSelectIndex in hasSelectIndexs {
                
                array.append(nums[hasSelectIndex])
            }
            returnValue.append(array)
            return
        }
        
        for index in 0...nums.count-1 {
            
            if hasSelectIndexs.contains(index) {
                
                continue
            }
            var array = hasSelectIndexs
            array.append(index)
            backtracking(nums,array)
            array.removeLast()
        }
    }
}

//面试题 08.12. 八皇后
class Solution_8Queens {
    
    var rows:[Int]?
    
    var colums:[Bool]?
    
    var leftTops:[Bool]?
    
    var rightTops:[Bool]?
    
    var size:Int = 8
    
    var times:Int = 0
    
    var lastStrings:[[String]] = Array.init()

    func solveNQueens(_ n: Int) -> [[String]] {
        
        self.size = n
        rows = Array.init(repeating: 0, count: n)
        colums = Array.init(repeating: false, count: n)
        leftTops = Array.init(repeating: false, count: 2*n-1)
        rightTops = Array.init(repeating: false, count: 2*n-1)
        backtracking(0)
        return lastStrings
    }
    
    func backtracking(_ row:Int) -> () {
        
        if row == self.size {
          
            var array:[String] = Array.init()
            for index in 0...self.rows!.count-1 {
                
                var string = ""
                for col in 0...self.colums!.count-1 {
                    
                    if self.rows![index]==col {
                        
                        string = string + "Q"
                    }else{
                        
                        string = string + "."
                    }
                }
                
                array.append(string)
            }
            lastStrings.append(array)
            times+=1
            return
        }
        
        for index in 0...self.size-1 {//选列
            
            if !isValid(row, index) {
                
                continue
            }
            rows![row] = index
            self.colums![index] = true
            self.leftTops![self.size - 1 - index + row] = true
            self.rightTops![row+index] = true
            backtracking(row+1)
            self.colums![index] = false
            self.leftTops![self.size - 1 - index + row] = false
            self.rightTops![row+index] = false
        }
    }
    
    func isValid(_ row:Int , _ colum:Int) -> Bool {
        
        if colums![colum] || rightTops![row+colum] || leftTops![self.size - 1 - colum + row]{
            
            return false
        }
        return true
    }
}
