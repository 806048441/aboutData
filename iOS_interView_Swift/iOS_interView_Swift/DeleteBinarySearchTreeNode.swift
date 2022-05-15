//
//  DeleteBinarySearchTreeNode.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/1.
//

import Foundation

//450. 删除二叉搜索树中的节点

class DeleteBinarySearchTreeNode_Solution{

    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {

        if root == nil {
            
            return root
        }
        
        let node_parent = node(key,root!)
        var node = node_parent.0
        var parent = node_parent.1
        if node == nil {
            
            return root
        }
        if node?.left != nil && node?.right != nil{
            
            let data = successorNode(node)
            let s = data.0
            parent = data.1
            node?.val = s!.val
            node = s
        }
               
//        [3,1,4,null,2]
        let replacement:TreeNode? = (node?.left == nil) ? node?.right : node?.left
        if replacement != nil {
            
            if parent == nil {
                
                return replacement
            }
            (node === parent?.left) ? (parent?.left = replacement) : (parent?.right = replacement)
        }else{
            
            if parent == nil {
                
                return nil
            }
            (node === parent?.left) ? (parent?.left = replacement) : (parent?.right = replacement)
        }
       
        
        return root
    }
    
    func node(_ key:Int , _ root:TreeNode) -> (TreeNode?,TreeNode?) {
        
        var node:TreeNode? = root
        var parent:TreeNode? = nil
        while node != nil {
            
            if key > node!.val {
                parent = node
                node = node!.right
            }else if key < node!.val {
                parent = node
                node = node!.left
            }else{
                
                return (node,parent)
            }
        }
        return (nil,nil)
    }
    
    private func successorNode(_ node:TreeNode?) -> (TreeNode?,TreeNode?) {
        
        if node == nil || node?.right == nil {
            
            return (nil,nil)
        }
        
        var parent = node!
        var cur = node!.right
        while cur?.left != nil {
            
            parent = cur!
            cur = cur?.left
        }
        return (cur!,parent)
    }
}

