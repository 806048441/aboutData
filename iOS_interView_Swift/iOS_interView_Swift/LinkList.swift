//
//  LinkList.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/2/15.
//

import UIKit

class Node <T: Equatable>{
    
    var key:T?
    var value:T?
    var useTime:Int = 0
    var next:Node?
    var prev:Node?
    init() {
        
    }
    
    init(_ key:T, _ value:T) {
        
        self.useTime = 0
        self.key = key
        self.value = value
    }
}

class LinkList <T: Equatable>{
    
    var head:Node<T>?
    var tail:Node<T>?
    var size:Int = 0
    init() {
        
        self.head = Node.init()
        self.tail = Node.init()
        self.head?.next = self.tail
        self.tail?.prev = self.head
        self.size = 0
    }
    
    func addAtHead(_ val: Node<T>) {
        
        val.next = self.head?.next
        val.prev = self.head
        self.head?.next?.prev = val
        self.head?.next = val
        self.size += 1
    }
    
    func removeAtTail() -> Node<T>?{
       
        let node = self.tail?.prev
        self.removeNode(node)
        return node ?? nil
    }
    
    func removeNode(_ val:Node<T>?) {
        
        if self.size == 0 || val == nil {
            
            return
        }
        val?.prev?.next = val?.next;
        val?.next?.prev = val?.prev;
        self.size -= 1
    }
}
