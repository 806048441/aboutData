//
//  LFUCache.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/2/14.
//

import UIKit

class LFUNode <T>{
    
    var key:T?
    var value:T?
    var useTime:Int = 0
    var next:LFUNode?
    var prev:LFUNode?
    init() {
        
    }
    
    init(_ key:T, _ value:T) {
        
        self.useTime = 0
        self.key = key
        self.value = value
    }
}

class LFULinkList {
    
    var head:LFUNode<Any>?
    var tail:LFUNode<Any>?
    var size:Int = 0
    init() {
        
        self.head = LFUNode.init()
        self.tail = LFUNode.init()
        self.head?.next = self.tail
        self.tail?.prev = self.head
        self.size = 0
    }
    
    func addAtHead(_ val: LFUNode<Any>) {
        
        val.next = self.head?.next
        val.prev = self.head
        self.head?.next?.prev = val
        self.head?.next = val
        self.size += 1
    }
    
    func removeAtTail() -> LFUNode<Any>?{
       
        let node = self.tail?.prev
        self.removeNode(node)
        return node ?? nil
    }
    
    func removeNode(_ val:LFUNode<Any>?) {
        
        if self.size == 0 || val == nil {
            
            return
        }
        val?.prev?.next = val?.next;
        val?.next?.prev = val?.prev;
        self.size -= 1
    }
}

class LFUCache {

    var keyTable:Dictionary = Dictionary<Int, LFUNode<Any>>.init()
    var timesTable:Dictionary<Int,LFULinkList> = Dictionary.init()
    var capacity = 0
    var minTime = -1
    var size = 0
    init(_ capacity: Int) {
        
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        
        if self.capacity == 0{
        
            return -1
        }
        let node = keyTable[key]
        if node == nil {
            
            return -1
        }else{
         
            self.updateNodeTimes(node!)
        }
        return node?.value as! Int
    }
    
    func put(_ key: Int, _ value: Int) {
        
        if self.capacity == 0 {
            
            return
        }
        var node = self.keyTable[key]
        if node == nil {
            
            if self.size == self.capacity {
                
                self.removeAtLate()
            }
            node = LFUNode.init(key, value)
            node!.useTime = 1
            self.minTime = 1
            self.keyTable.updateValue(node!, forKey: key)
            var linkList = self.timesTable[self.minTime]
            if linkList == nil {
                
                linkList = LFULinkList.init()
            }
            linkList?.addAtHead(node!)
            self.timesTable.updateValue(linkList!, forKey: 1)
            self.size += 1
        }else{
            
            node!.value = value
            self.updateNodeTimes(node!)
        }
    }
    
    func removeAtLate() {
        
        if self.size == 0 {
            
            return
        }
        let linkList = self.timesTable[self.minTime]
        let removeNode = linkList?.removeAtTail()
        self.keyTable.removeValue(forKey: removeNode?.key as! Int)
        if linkList?.size == 0 {
            
            self.timesTable.removeValue(forKey: self.minTime)
        }
        self.size -= 1
    }
    
    func updateNodeTimes(_ node:LFUNode<Any>) {
     
        let originLinkList = self.timesTable[node.useTime]
        originLinkList?.removeNode(node)
        if originLinkList?.size == 0 {
            
            self.timesTable.removeValue(forKey: node.useTime)
            if self.minTime == node.useTime {
                
                self.minTime += 1
            }
        }
        node.useTime += 1
        var presentLinkList = self.timesTable[node.useTime]
        if presentLinkList == nil {
            
            presentLinkList = LFULinkList.init()
        }
        presentLinkList?.addAtHead(node)
        self.timesTable.updateValue(presentLinkList!, forKey: node.useTime)
    }
}
