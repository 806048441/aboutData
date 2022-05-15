//
//  HeapSort.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/19.
//

import Foundation

extension Dictionary {
    

}

struct topKObject:Comparable {
    
    var num:Int = 0
    var times:Int = 0
    
    init(_ num:Int, _ times:Int ) {
        
        self.num = num
        self.times = times
    }
    
    
    static func == (lhs: topKObject, rhs: topKObject) -> Bool {
    
        return lhs.times == rhs.times
    }
    
    static func < (lhs:topKObject, rhs: topKObject) -> Bool {
        
        return lhs.times < rhs.times
    }
}

struct topKObject2:Comparable {
  
    var word:String = ""
    var times:Int = 0

    init(_ word:String, _ times:Int) {
        
        self.word = word
        self.times = times
    }
    
    
    static func == (lhs: topKObject2, rhs: topKObject2) -> Bool {
    
        return lhs.times == rhs.times
    }
    
    static func < (lhs:topKObject2, rhs: topKObject2) -> Bool {
        
        if lhs.times == rhs.times {
            
            return lhs.word.compare(rhs.word) == ComparisonResult.orderedDescending
        }
        return lhs.times < rhs.times
    }
}


class HeapSort {
    
    /**-----堆排序-----*/
    static func heapSort1(_ nums: [Int]) -> [Int] {
        
        if nums.count < 2 {
            
            return nums
        }
        
        let heap = MaxHeap<Int>.init(nums)
        
        var lastNums:[Int] = Array.init()
        while !heap.isEmpty() {
            
            lastNums.append(heap.remove()!)
        }
        
        return lastNums
    }
    

    
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {

      
        var map:[Int:Int] = Dictionary.init()
        for num in nums {
            
            if map.keys.contains(num) {
                
                map[num] = map[num]!+1
            }else{
                
                map[num] = 1
            }
        }
        
        
        let heap = MinHasSizeHeap<topKObject>.init(k)
        for key in map.keys {
            
            heap.add(topKObject.init(key, map[key]!))
        }
        var lastNums:[Int] = Array.init()
        while !heap.isEmpty() {
            
            lastNums.append(heap.remove()!.num)
        }
        
        return lastNums
    }
    
    func topKFrequent2(_ words: [String], _ k: Int) -> [String] {

        var map:[String:topKObject2] = Dictionary.init()
        for index in 0...words.count-1 {
            
            let word = words[index]
            if map.keys.contains(word) {
                
                var obj = map[word]
                obj?.times+=1
                map[word] = obj
            }else{
                
                let obj = topKObject2.init(word, 1)
                map[word] = obj
            }
        }
        
        let heap = MinHasSizeHeap<topKObject2>.init(k)
        for key in map.keys {
            
            heap.add(map[key]!)
        }
        
        var lastNums:[String] = Array.init()
        var index = 0
        while index < k {
            
            lastNums.insert(heap.remove()!.word, at: 0)
            index += 1
        }
        
        return lastNums
    }
}



