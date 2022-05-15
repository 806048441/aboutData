//
//  MakeNums.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/16.
//

import Foundation

class MakeNums {
    
    static func makeIntRandomNums(_ min:Int , _ max:Int , _ count:Int) -> [Int]{
        
        if min > max || count <= 0 {
            
            return []
        }
        
        var nums:[Int] = Array.init()
        var index = 0
        while index < count {
            
            nums.append(Int.random(in: min...max))
            index += 1
        }
        return nums
    }
    
    static func makeIntAscSortNums(_ min:Int , _ max:Int) -> [Int]{
        
        if min > max {
            
            return []
        }
        var nums:[Int] = Array.init()
        var index = 0
        let length = max - min + 1
        while index < length {
            
            nums.append(min+index)
            index += 1
        }
        return nums
    }
    
    static func makeIntDescSortNums(_ min:Int , _ max:Int) -> [Int]{
        
        if min > max {
            
            return []
        }
        var nums:[Int] = Array.init()
        var index = 0
        let length = max - min + 1
        while index < length {
            
            nums.append(max - index)
            index += 1
        }
        return nums
    }
    
    static func makeIntHeadAscSortNums(_ min:Int , _ max:Int , _ ascCount:Int) -> [Int]{
        
        if ascCount > max - min + 1 {
            
            return []
        }
        var nums:[Int] = Array.init()
        var index = 0
        let length = max - min + 1
        while index < length {
            
            if index < ascCount {
                
                nums.append(min + index)
            }else{
                
                nums.append(Int.random(in: min+ascCount...max))
            }
            index += 1
        }
        return nums
    }
    
    static func makeIntHeadDescSortNums(_ min:Int , _ max:Int , _ descCount:Int) -> [Int]{
        
        if descCount > max - min + 1 {
            
            return []
        }
        var nums:[Int] = Array.init()
        var index = 0
        let length = max - min + 1
        while index < length {
            
            if index < descCount {
                
                nums.append(max - index)
            }else{
                
                nums.append(Int.random(in: min...max-descCount))
            }
            index += 1
        }
        return nums
    }
    
    static func makeIntTailAscSortNums(_ min:Int , _ max:Int , _ ascCount:Int) -> [Int]{
        
        let length = max - min + 1
        if ascCount > length {
            
            return []
        }
        var nums:[Int] = Array.init()
        var index = 0
        while index < length {
            
            if index < ascCount {
                
                nums.insert(max-index, at: 0)
            }else{
                
                nums.insert(Int.random(in: min...max-ascCount), at: 0)
            }
            index += 1
        }
        return nums
    }
    
    static func makeIntTailDescSortNums(_ min:Int , _ max:Int , _ descCount:Int) -> [Int]{
        
        let length = max - min + 1
        if descCount > length {
            
            return []
        }
        var nums:[Int] = Array.init()
        var index = 0
        while index < length {
            
            if index < descCount {
                
                nums.append(max-index)
            }else{
                
                nums.insert(Int.random(in: min...max-descCount), at: 0)
            }
            index += 1
        }
        return nums
    }
}
