//
//  isBalanceBinarySearchTress.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/2.
//

import Foundation

//110. 平衡二叉树

class IsBalanceBinarySearchTree_Solution {
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        
        if root == nil {
            
            return true
        }
        return abs(getHeight(root?.left)-getHeight(root?.right))<=1 && isBalanced(root?.left) && isBalanced(root?.right)
    }
    
    func getHeight(_ node:TreeNode?) -> Int {
        
        if node == nil {
            
            return 0
        }
        return max(getHeight(node?.left), getHeight(node?.right)) + 1
    }
}
