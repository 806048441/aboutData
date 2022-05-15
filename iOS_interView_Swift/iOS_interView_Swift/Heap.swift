//
//  Heap.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/19.
//

import Foundation

class MaxHeap<E:Comparable> {
    
    var dt:[E] = Array.init()
    
    var size: Int {
        
        get {
            
            return self.dt.count
        }
    }
    
    convenience init() {
        
        self.init([])
    }
    
    init(_ elements:[E]) {
        
        self.dt = elements
        if self.size>0 {
            
            for index in (0...(self.size>>1-1)).reversed() {
                siftDown(index)
            }
        }
    }
    
    func isEmpty() -> Bool {
        
        return self.size == 0
    }
    
    func clear() -> () {
        
        dt.removeAll()
    }
    
    func add(_ element:E) -> () {
        
        self.dt.append(element)
        self.siftUp(self.size-1)
    }
    
    func top() -> E? {
        
        return self.isEmpty() ? nil : self.dt.first
    }
    
    func remove() -> E? {
        
        if self.isEmpty() {
            
            return nil
        }
        if self.size == 1 {
            
            let result = self.dt.remove(at: 0)
            return result
        }
        let removeElement = self.dt[0]
        self.dt[0] = self.dt.last!
        self.dt[self.size-1] = removeElement
        self.dt.removeLast()
        self.siftDown(0)
        return removeElement
    }
    
    private func siftUp(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        while opIndex > 0 {
            
            let parentIndex = (opIndex-1) >> 1
            let parentElement = self.dt[parentIndex]
            if siftElement <= parentElement  {
                
                break
            }
            self.dt[opIndex] = parentElement
            opIndex = parentIndex
        }
        self.dt[opIndex] = siftElement
    }
    
    private func siftDown(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        let half = self.size >> 1
        while opIndex < half  {
            
            var childIndex = (opIndex<<1) + 1
            var child = self.dt[childIndex]
            let rightChildIndex = childIndex + 1
            if rightChildIndex < self.size && self.dt[rightChildIndex] > child {
                
                childIndex = rightChildIndex
                child = self.dt[rightChildIndex]
            }
            if siftElement >= child {
                
                break
            }
            self.dt[opIndex] = child
            opIndex = childIndex
        }
        self.dt[opIndex] = siftElement
    }
}


class MinHeap<E:Comparable> {
    
    var dt:[E] = Array.init()
    
    var size: Int {
        
        get {
            
            return self.dt.count
        }
    }
    
    convenience init() {
        
        self.init([])
    }
    
    init(_ elements:[E]) {
        
        self.dt = elements
        if self.size > 0 {
            for index in (0...(self.size>>1-1)).reversed() {
                siftDown(index)
            }
        }
    }
    
    func isEmpty() -> Bool {
        
        return self.size == 0
    }
    
    func clear() -> () {
        
        dt.removeAll()
    }
    
    func add(_ element:E) -> () {
        
        self.dt.append(element)
        self.siftUp(self.size-1)
    }
    
    func top() -> E? {
        
        return self.isEmpty() ? nil : self.dt.first
    }
    
    func remove() -> E? {
        
        if self.isEmpty() {
            
            return nil
        }
        if self.size == 1 {
            
            let result = self.dt.remove(at: 0)
            return result
        }
        let removeElement = self.dt[0]
        self.dt[0] = self.dt.last!
        self.dt[self.size-1] = removeElement
        self.dt.removeLast()
        self.siftDown(0)
        return removeElement
    }
    
    private func siftUp(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        while opIndex > 0 {
            
            let parentIndex = (opIndex-1) >> 1
            let parentElement = self.dt[parentIndex]
            if siftElement >= parentElement  {
                
                break
            }
            self.dt[opIndex] = parentElement
            opIndex = parentIndex
        }
        self.dt[opIndex] = siftElement
    }
    
    private func siftDown(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        let half = self.size >> 1
        while opIndex < half  {
            
            var childIndex = (opIndex<<1) + 1
            var child = self.dt[childIndex]
            let rightChildIndex = childIndex + 1
            if rightChildIndex < self.size && self.dt[rightChildIndex] < child {
                
                childIndex = rightChildIndex
                child = self.dt[rightChildIndex]
            }
            if siftElement <= child {
                
                break
            }
            self.dt[opIndex] = child
            opIndex = childIndex
        }
        self.dt[opIndex] = siftElement
    }
}

class MinHasSizeHeap<E:Comparable> {
    
    var dt:[E] = Array.init()
    
    var maxSize = 10
    
    var size: Int {
        
        get {
            
            return self.dt.count
        }
    }
    
    init(_ maxSize:Int) {
        
        self.maxSize = maxSize
    }
    
    func isEmpty() -> Bool {
        
        return self.size == 0
    }
    
    func clear() -> () {
        
        dt.removeAll()
    }
    
    func add(_ element:E) -> () {
        
        if self.size == self.maxSize {
            
            if element > self.top()! {
                
                self.remove()
                self.add(element)
            }
        }else{
            
            self.dt.append(element)
            self.siftUp(self.size-1)
        }
    }
    
    func top() -> E? {
        
        return self.isEmpty() ? nil : self.dt.first
    }
    
    func remove() -> E? {
        
        if self.isEmpty() {
            
            return nil
        }
        if self.size == 1 {
            
            let result = self.dt.remove(at: 0)
            return result
        }
        let removeElement = self.dt[0]
        self.dt[0] = self.dt.last!
        self.dt[self.size-1] = removeElement
        self.dt.removeLast()
        self.siftDown(0)
        return removeElement
    }
    
    private func siftUp(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        while opIndex > 0 {
            
            let parentIndex = (opIndex-1) >> 1
            let parentElement = self.dt[parentIndex]
            if siftElement >= parentElement  {
                
                break
            }
            self.dt[opIndex] = parentElement
            opIndex = parentIndex
        }
        self.dt[opIndex] = siftElement
    }
    
    private func siftDown(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        let half = self.size >> 1
        while opIndex < half  {
            
            var childIndex = (opIndex<<1) + 1
            var child = self.dt[childIndex]
            let rightChildIndex = childIndex + 1
            if rightChildIndex < self.size && self.dt[rightChildIndex] < child {
                
                childIndex = rightChildIndex
                child = self.dt[rightChildIndex]
            }
            if siftElement <= child {
                
                break
            }
            self.dt[opIndex] = child
            opIndex = childIndex
        }
        self.dt[opIndex] = siftElement
    }
}
