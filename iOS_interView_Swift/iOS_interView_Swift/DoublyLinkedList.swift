//
//  DoublyLinkedList.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/2/13.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public var prev: ListNode?
    public init() { self.val = 0; self.next = nil; self.prev = nil}
    public init(_ val: Int) { self.val = val; self.next = nil; self.prev = nil}
    public init(_ val: Int, _ next: ListNode?, _ prev: ListNode?) { self.val = val; self.next = next; self.prev = prev}
}



class DoublyLinkedList {
    
    func swapPairs(_ head: ListNode?) -> ListNode? {

        if head == nil && head?.next == nil {
            
            return head
        }
        let newHead = head?.next
        head?.next = swapPairs(newHead?.next)
        newHead?.next = head
        return newHead
    }
    
    var head:ListNode?
    var tail:ListNode?
    var size:Int = 0
    init() {
        
        self.head = nil
        self.tail = nil
        self.size = 0
    }
    
    func getNode(_ index:Int) -> ListNode? {
        
        if index >= self.size || index < 0{
            
            return nil
        }
        var cur:ListNode? = head
        if index < self.size/2{

            var i = 0
            while i < index {

                cur = cur?.next
                i += 1
            }
        }else{

            cur = self.tail
            var i = 0
            while i < self.size - index - 1{

                cur = cur?.prev
                i += 1
            }
        }
        return cur
    }
    
    func get(_ index: Int) -> Int {
        
        let node = self.getNode(index)
        if node != nil {
            
            return node?.val ?? -1
        }
        return -1
    }
    
    func addAtHead(_ val: Int) {
        
        self.addAtIndex(0, val)
    }
    
    func addAtTail(_ val: Int) {
        
        self.addAtIndex(self.size, val)
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        
        if index > self.size {
            
            return
        }
        if index <= 0 {
            
            let newHead = ListNode.init(val, self.head, nil)
            if self.size == 0 {
                
                self.head = newHead
                self.tail = self.head
            }else if self.size == 1{
                
                self.head?.prev = newHead
                self.head = newHead
                self.tail?.prev = self.head
                self.tail?.next = nil
            }else{
                
                self.head?.prev = newHead
                self.head = newHead
            }
        }else if index == self.size{
            
            let newTail = ListNode.init(val, nil, self.tail)
            if self.size == 0 {
                
                self.tail = newTail
                self.head = self.tail
            }else if self.size == 1 {
                
                self.tail?.next = newTail
                self.tail = newTail
                self.head?.next = self.tail
                self.head?.prev = nil
            }else{
                
                self.tail?.next = newTail
                self.tail = newTail
            }
        }else{
            
            let prev = self.getNode(index-1)
            let next = self.getNode(index)
            let node = ListNode.init(val, next, prev)
            prev?.next = node
            next?.prev = node
        }
        self.size += 1
    }

    
    func deleteAtIndex(_ index: Int) {
        
        if index >= self.size || index < 0 {
            
            return
        }
        
        if index == 0 {
            
            if self.size == 1{
            
                self.head = nil
                self.tail = nil
            }else if self.size == 2{
                
                self.head = self.head?.next
                self.head?.prev = nil
                self.tail = self.head
            }else{
                
                self.head = self.head?.next
                self.head?.prev = nil
            }
        }else if index == self.size-1{
            
            if self.size == 1{
            
                self.head = nil
                self.tail = nil
            }else if self.size == 2{
                
                self.tail = self.tail?.prev
                self.tail?.next = nil
                self.head = self.tail
            }else{
                
                self.tail = self.tail?.prev
                self.tail?.next = nil
            }
        }else{
            
            let prev = self.getNode(index-1)
            let next = self.getNode(index+1)
            prev?.next = next
            next?.prev = prev
        }
        self.size -= 1
    }
}

/**-----头结点 尾节点 为伪节点的实现方式-----*/
class DoublyLinkedList2 {

    var head:ListNode?
    var tail:ListNode?
    var size:Int = 0
    init() {
        
        self.head = ListNode.init(-1, nil, nil)
        self.tail = ListNode.init(-1, nil, self.head)
        self.head?.next = self.tail
        self.size = 0
    }
    
    func getNode(_ index:Int) -> ListNode? {
        
        if index < 0 {
            
            return self.head
        }
        if index >= self.size{
            
            return self.tail
        }
        var cur:ListNode? = self.head
        if index < self.size/2{

            var i = 0
            while i < index + 1 {

                cur = cur?.next
                i += 1
            }
        }else{

            cur = self.tail
            var i = 0
            while i < self.size - index{

                cur = cur?.prev
                i += 1
            }
        }
        return cur
    }
    
    func get(_ index: Int) -> Int {
        
        let node = self.getNode(index)
    
        return node?.val ?? -1
    }
    
    func addAtHead(_ val: Int) {
        
        self.addAtIndex(0, val)
    }
    
    func addAtTail(_ val: Int) {
        
        self.addAtIndex(self.size, val)
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        
        if index > self.size {
            
            return
        }
        let prev = self.getNode(index-1)
        let next = self.getNode(index)
        let node = ListNode.init(val, next, prev)
        prev?.next = node
        next?.prev = node
        self.size += 1
    }

    
    func deleteAtIndex(_ index: Int) {
        
        if index >= self.size || index < 0 {
            
            return
        }
        let prev = self.getNode(index-1)
        let next = self.getNode(index+1)
        prev?.next = next
        next?.prev = prev
        self.size -= 1
    }
}


func test() -> Void {
    
    var list:DoublyLinkedList = DoublyLinkedList.init()
    let ops = ["MyLinkedList","addAtHead","addAtTail","addAtTail","get","get","addAtTail","addAtIndex","addAtHead","addAtHead","addAtTail","addAtTail","addAtTail","addAtTail","get","addAtHead","addAtHead","addAtIndex","addAtIndex","addAtHead","addAtTail","deleteAtIndex","addAtHead","addAtHead","addAtIndex","addAtTail","get","addAtIndex","addAtTail","addAtHead","addAtHead","addAtIndex","addAtTail","addAtHead","addAtHead","get","deleteAtIndex","addAtTail","addAtTail","addAtHead","addAtTail","get","deleteAtIndex","addAtTail","addAtHead","addAtTail","deleteAtIndex","addAtTail","deleteAtIndex","addAtIndex","deleteAtIndex","addAtTail","addAtHead","addAtIndex","addAtHead","addAtHead","get","addAtHead","get","addAtHead","deleteAtIndex","get","addAtHead","addAtTail","get","addAtHead","get","addAtTail","get","addAtTail","addAtHead","addAtIndex","addAtIndex","addAtHead","addAtHead","deleteAtIndex","get","addAtHead","addAtIndex","addAtTail","get","addAtIndex","get","addAtIndex","get","addAtIndex","addAtIndex","addAtHead","addAtHead","addAtTail","addAtIndex","get","addAtHead","addAtTail","addAtTail","addAtHead","get","addAtTail","addAtHead","addAtTail","get","addAtIndex"]
    
    let opIndexs = [[],[84],[2],[39],[3],[1],[42],[1,80],[14],[1],[53],[98],[19],[12],[2],[16],[33],[4,17],[6,8],[37],[43],[11],[80],[31],[13,23],[17],[4],[10,0],[21],[73],[22],[24,37],[14],[97],[8],[6],[17],[50],[28],[76],[79],[18],[30],[5],[9],[83],[3],[40],[26],[20,90],[30],[40],[56],[15,23],[51],[21],[26],[83],[30],[12],[8],[4],[20],[45],[10],[56],[18],[33],[2],[70],[57],[31,24],[16,92],[40],[23],[26],[1],[92],[3,78],[42],[18],[39,9],[13],[33,17],[51],[18,95],[18,33],[80],[21],[7],[17,46],[33],[60],[26],[4],[9],[45],[38],[95],[78],[54],[42,86]]

    for i in 0..<ops.count {
        
        let op = ops[i]
        let indexs:[Int] = opIndexs[i]
        switch op {
        case "MyLinkedList":
            list = DoublyLinkedList.init()
            break
        case "get":
            let getValue = list.get(indexs[0])
            print("getValue=\(getValue)")
            break
        case "addAtHead":
            list.addAtHead(indexs[0])
            break
        case "addAtTail":
            list.addAtTail(indexs[0])
            break
        case "addAtIndex":
            list.addAtIndex(indexs[0], indexs[1])
            break
        case "deleteAtIndex":
            list.deleteAtIndex(indexs[0])
            break
        default:
            
            break
        }
    }
    
}
