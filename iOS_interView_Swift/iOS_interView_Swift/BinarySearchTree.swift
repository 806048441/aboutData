//
//  BinarySearchTree.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/4.
//

import UIKit

//protocol BinaryComparable {
//
//    associatedtype E
//    func compare(_ element:E) -> Int;
//}
//
//class BinaryComparator<E> {
//
//    func compare(_ element1:E,_ element2:E) -> Int {
//
//        return 0
//    };
//}

//class BinaryPersonComparator1:BinaryComparator<BinaryPerson> {
//
//    override func compare(_ element1:BinaryPerson,_ element2:BinaryPerson) -> Int {
//
//        return element1.age - element2.age
//    };
//}


class BinaryPerson :CustomStringConvertible,Comparable{
    
    static func < (lhs: BinaryPerson, rhs: BinaryPerson) -> Bool {
        
        return lhs.age < rhs.age
    }
    
    static func == (lhs: BinaryPerson, rhs: BinaryPerson) -> Bool {
        
        return lhs.age == rhs.age
    }
    
    var age = 18
    var height = 20.0
    var name = "name"
    init () {
        
    }
    
    init(_ age:Int, _ height:Double, _ name:String) {
        
        self.age = age
        self.height = height
        self.name = name
    }
    
    var description: String {
        
        return "姓名=\(self.name)" + ",身高=\(self.height)" + "年纪=\(self.age)"
    }
}

class BinarySearchTree<E:Comparable>:BinaryTree<E> {
        
    func add(_ element:E?) -> () {

        if element == nil {

            return
        }
        self.size += 1
        /**-----添加第一个节点-----*/
        if self.root == nil {

            self.root = BinaryNode.init(element!, nil)
        }else{

            var node:BinaryNode<E>? = self.root
            var parent:BinaryNode<E>?
            var compareResult = 0
            while node != nil {

                parent = node
                if element! > node!.element{

                    node = node?.right
                    compareResult = 1
                }else if element! < node!.element{

                    node = node?.left
                    compareResult = -1
                }else{//相等的情况

                    node!.element = element!
                    return
                }
            }
            let newNode:BinaryNode<E> = BinaryNode.init(element!, parent)
            if compareResult > 0 {

                parent?.right = newNode
            }else{

                parent?.left = newNode
            }
        }
    }
    
    func contains(_ element:E) -> Bool {
        
        return node(element) != nil
    }
    
    private func node(_ element:E) -> BinaryNode<E>? {
        
        if root == nil {
            
            return nil
        }
        
        var node:BinaryNode<E>? = self.root
        while node != nil {

            if element > node!.element{

                node = node?.right
            }else if element < node!.element{

                node = node?.left
            }else{//相等的情况

                return node
            }
        }
        return node
    }

    func remove(_ element:E) -> () {
        
        removeNode(node(element))
    }

    private func removeNode(_ node:BinaryNode<E>?) -> () {

        if node == nil {
            
            return
        }
        
        var cur = node
        if hasTwoChildren(cur) {
            
            let s = successorNode(cur)
            cur?.element = s!.element
            cur = s!
        }
        
        let replacement = (cur?.left == nil) ? cur?.right : cur?.left
        
        if replacement != nil {
            
            replacement?.parent = cur?.parent
        }
        
        if cur?.parent == nil {
            
            root = replacement
        }else{
            
            (cur === cur?.parent?.left) ? (cur?.parent?.left = replacement) : (cur?.parent?.right = replacement)
        }
    }
    
    private func hasTwoChildren(_ node:BinaryNode<E>?) -> Bool {
        
        if node == nil {
            
            return false
        }
        return node?.left != nil && node?.right != nil
    }
    
    private func predecessorNode(_ node:BinaryNode<E>?) -> BinaryNode<E>? {
        
        if root == nil || node == nil || node?.left == nil {
            
            return nil
        }
        
        var cur = node?.left
        while cur?.right != nil {
            
            cur = cur?.right
        }
        return cur!
    }
    
    private func successorNode(_ node:BinaryNode<E>?) -> BinaryNode<E>? {
        
        if root == nil || node == nil || node?.right == nil {
            
            return nil
        }
        
        var cur = node!.right
        while cur?.left != nil {
            
            cur = cur?.left
        }
        return cur!
    }
}
