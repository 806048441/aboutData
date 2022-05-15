//
//  SingleLinkList.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/5/3.
//

import Foundation
/// 头结点是伪节点的单链表
class SingleList<Element>: LinkListProtocol,CustomStringConvertible {
    
    private class SingleNode<Element> {
        var val:Element?
        var next:SingleNode? = nil
        init() {}
        init(_ val:Element?) {self.val = val;self.next = nil}
        init(_ val:Element? , _ next:SingleNode?) {self.val = val;self.next = next}
    }
    
    private var head:SingleNode<Element> = SingleNode.init(nil, nil)
    
    typealias Element = Element

    var size: Int = 0
    
    func add(_ element: Element) {
        
        var cur = head
        while cur.next != nil {
            
            cur = cur.next!
        }
        cur.next = SingleNode.init(element, nil)
        self.size += 1
    }
    
    func add(_ index: Int, _ element: Element) {
        
        if index > self.size {
            
            return
        }
        var curIndex = 0
        var cur = head
        while curIndex < index {
            
            cur = cur.next!
            curIndex += 1
        }
        let originNext = cur.next
        cur.next = SingleNode.init(element, originNext)
        self.size += 1
    }
    
    func clear() {
        
        self.head.next = nil
        self.size = 0
    }
    
    func remove() {
        
        if self.size == 0 {
            
            return
        }
        var cur = head
        while cur.next?.next != nil {
            
            cur = cur.next!
        }
        cur.next = nil
        self.size -= 1
    }
    
    func remove(_ index: Int) {
        
        if index > self.size - 1 {
            
            return
        }
        var curIndex = 0
        var cur = head
        while curIndex < index {
            
            cur = cur.next!
            curIndex += 1
        }
        let originNext = cur.next
        cur.next = originNext?.next
        self.size -= 1
    }
    
    func isEmpty() -> Bool {
        
        return self.size == 0
    }
    
    var description:String {
            
        var string = "start"
        var cur = head
    
        while cur.next != nil {
            
            cur = cur.next!
            string += "->\(cur.val!)"
        }
        
        string += "->end"
        return string
    }
}
