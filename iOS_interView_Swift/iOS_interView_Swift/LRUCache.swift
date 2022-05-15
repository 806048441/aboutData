//
//  LRUCache.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/2/13.
//

import Foundation

class LRUNode {
    
    var key:Int?
    var value:Int?
    var next:LRUNode?
    var prev:LRUNode?
    init() {
        
    }
    
    init(_ key:Int, _ value:Int) {
        
        self.key = key
        self.value = value
    }
}

class LRULinkList {
    
    var head:LRUNode?
    var tail:LRUNode?
    var size:Int = 0
    init() {
        
        self.head = LRUNode.init()
        self.tail = LRUNode.init()
        self.head?.next = self.tail
        self.tail?.prev = self.head
        self.size = 0
    }
    
    func addAtHead(_ val: LRUNode) {
        
        val.next = self.head?.next
        val.prev = self.head
        self.head?.next?.prev = val
        self.head?.next = val
        self.size += 1
    }
    
    func removeAtTail() -> LRUNode?{
       
        let node = self.tail?.prev
        self.removeNode(node)
        return node ?? nil
    }
    
    func removeNode(_ val:LRUNode?) {
        
        if self.size == 0 || val == nil {
            
            return
        }
        val?.prev?.next = val?.next;
        val?.next?.prev = val?.prev;
        self.size -= 1
    }
}

class LRUCache {
    
    var cache:Dictionary<Int, LRUNode> = Dictionary.init()
    var list:LRULinkList = LRULinkList.init()
    var capacity = 0
    init(_ capacity: Int) {
        
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        
        let node = cache[key]
        if node != nil {
            
            list.removeNode(node)
            list.addAtHead(node!)
        }
        return node?.value ?? -1
    }
    
    func put(_ key: Int, _ value: Int) {
        
        var node = cache[key]
        if node == nil {
            
            if list.size == self.capacity {
                
                let removeNode = list.removeAtTail()
                cache.removeValue(forKey: removeNode?.key ?? 0)
            }
            node = LRUNode.init(key, value)
            cache.updateValue(node!, forKey: key)
            list.addAtHead(node!)
        }else{
            
            node!.value = value
            list.removeNode(node)
            list.addAtHead(node!)
        }
    }
}
