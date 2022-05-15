//
//  MyHashSet.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/2/15.
//

import Foundation

class MyHashSet {

    var linkList = LinkList<Int>.init()
    var keys = Array<Int>.init()
    init() {

        
    }
    
    func add(_ key: Int) {

        if !self.keys.contains(key) {
            
            let node:Node = Node<Int>.init()
            node.key = key
            linkList.addAtHead(node)
            keys.append(key)
        }
    }
    
    func remove(_ key: Int) {
        
        keys.removeAll { value in
            
            key == value
        }
        var node = self.linkList.head
        while node != nil {
            
            if node?.key == key{
                
                linkList.removeNode(node)
                break
            }
            node = node?.next
        }
    }
    
    func contains(_ key: Int) -> Bool {

        var node = self.linkList.head
        while node != nil {
            
            if node?.key == key{
                
                return true
            }
            node = node?.next
        }
        return false
    }
}
