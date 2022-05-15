//
//  BinaryTreeIsSearchTree.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/6.
//

import UIKit

class BinaryTreeIsSearchTree {
    
    var dataSource:[Int] = Array.init()
    func inOrderTraverseNode(_ node:TreeNode?) -> () {
        //递归写法停止得实现协议 先放这里
        if node == nil {
            
            return
        }
        inOrderTraverseNode(node!.left)
        dataSource.append(node!.val)
        inOrderTraverseNode(node!.right)
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {

        if root == nil {
            
            return true
        }
        inOrderTraverseNode(root!)
        if dataSource.count == 1 {
            
            return true
        }
        var onePoint = dataSource[0]
        for index in 1..<dataSource.count {
            
            let num = dataSource[index]
            if onePoint >= num {
                
                return false
            }
            onePoint = num
        }
        return true
    }
}
