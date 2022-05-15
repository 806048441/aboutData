//
//  BinaryTree.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/31.
//

import Foundation

class BinaryNode<E> {
    
    var element:E
    var left:BinaryNode?
    var right:BinaryNode?
    var parent:BinaryNode?
    var height:Int?
    init(_ element:E, _ parent:BinaryNode<E>?) {
        
        self.element = element
        self.parent = parent
    }
}

class BinaryTree<E:Comparable> {
    
    var root:BinaryNode<E>?
    var size:Int = 0
    
    func isEmpty() -> Bool {

        return self.size == 0
    }

    func clear() -> () {

        self.size = 0
        self.root = nil
    }
    
    func preTraverseNode(_ node:BinaryNode<E>?, _ block:((E)->Bool)?) -> () {
        //递归写法停止得实现协议 先放这里
        if node == nil {

            return
        }
        if block != nil {
            let stop = block!(node!.element)
            if stop {

                return
            }
        }
        preTraverseNode(node?.left,block)
        preTraverseNode(node?.right,block)
    }

    func inOrderTraverseNode(_ node:BinaryNode<E>?, _ block:((E)->Bool)?) -> () {
        
        if node == nil {
            
            return
        }
        var stk:[BinaryNode<E>] = Array.init()
        var root = node
        while (root != nil || stk.count != 0) {
            
            while (root != nil) {
                
                stk.append(root!)
                root = root!.left;
            }
            root = stk.removeLast();
            if (block != nil) {
                
                let stop = block!(root!.element)
                if stop {
                    
                    break
                }
            }
            root = root?.right;
        }
//递归写法停止得实现协议 先放这里
//        if node == nil {
//
//            return
//        }
//        inOrderTraverseNode(node!.left, block)
//        if block != nil {
//
//            let stop = block!(node!.element)
//            if stop {
//
//                return
//            }
//        }
//        inOrderTraverseNode(node!.right,block)
    }

    func postOrderTraverseNode(_ node:BinaryNode<E>?, _ block:((E)->Bool)?) -> () {
        //递归写法停止得实现协议 先放这里
        if node == nil {

            return
        }
        var left = node?.left
        var el:E?
        while left != nil {

            left = left?.left
            el = left?.element
        }
//        postOrderTraverseNode(node!.left,block)
//        postOrderTraverseNode(node!.right,block)
//        if block != nil {
//            let stop = block!(node!.element)
//            if stop {
//
//                return
//            }
//        }
    }

    /// 层序遍历
    /// - Parameters:
    ///   - node: 要遍历的节点
    ///   - block: 当前节点回调 返回值为是否停止 true停止 false不停止
    /// - Returns:
    func levelOrderTraverseNode(_ node:BinaryNode<E>?, _ block:((E)->Bool)) -> () {
        if node == nil {

            return
        }
        var queue:[BinaryNode<E>] = Array.init()
        queue.append(node!)
        while !queue.isEmpty {

            let cur = queue.removeFirst()
            let stop = block(cur.element)
            if stop {

                return
            }
            if cur.left != nil {

                queue.append(cur.left!)
            }
            if cur.right != nil {

                queue.append(cur.right!)
            }
        }
    }
}

