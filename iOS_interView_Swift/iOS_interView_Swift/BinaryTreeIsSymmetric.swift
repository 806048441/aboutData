//
//  BinaryTreeIsSymmetric.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/7.
//

import UIKit

//101. 对称二叉树
class BinaryTreeIsSymmetric {
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        if root == nil {
            
            return true
        }
        
        return check(root, root)
    }
    
    func check(_ p:TreeNode?,_ q:TreeNode?) -> Bool {
        
        if p == nil && q == nil {
            
            return true
        }
        if p == nil || q == nil {
            
            return false
        }
        
        return p?.val == q?.val && check(p?.left, q?.right) && check(p?.right, q?.left)
    }
}
