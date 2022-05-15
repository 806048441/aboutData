//
//  StockPrice.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/6.
//

import UIKit

class StockPrice {

    var data:Dictionary<Int, Int> = Dictionary.init()
    var maxTime:Int?
    var sortValues:[Int] = Array.init()
    init() {
        
    }
    
    func sortAdd(_ v: Int, _ arr: inout [Int]) -> Void {
        
        var mid = arr.count>>1
        var left = 0
        var right = arr.count - 1
        var index = arr.count

        while left <= right {
            
            mid = (right - left)>>1 + left
            let value = arr[mid]
            if v < value {
                index = mid
                right = mid - 1
            }else{
                
                left = mid + 1
            }
        }
        
        arr.insert(v, at: index)
    }
    
    func update(_ timestamp: Int, _ price: Int) {
        
        maxTime = max(timestamp, maxTime ?? -1)
        if self.data.keys.contains(timestamp) {
            
            let removeValue = self.data[timestamp]!
            let index = self.sortValues.firstIndex { content in
                
                content == removeValue
            }
            self.sortValues.remove(at: index!)
        }
        data.updateValue(price, forKey: timestamp)
        self.sortAdd(price, &self.sortValues)
    }
    
    func current() -> Int {
        
        if data.count != 0 {
            
            return data[maxTime!]!
        }
         
        return 0
    }
    
    func maximum() -> Int {
        
        if data.count != 0 {
            
            return sortValues.last!
        }
        return 0
    }
    
    func minimum() -> Int {
        
        if data.count != 0 {
            
            return sortValues.first!
        }
        return 0
    }
}
