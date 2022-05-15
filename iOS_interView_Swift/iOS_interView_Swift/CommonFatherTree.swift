//
//  CommonFatherTree.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/1.
//

import Foundation

//235. 二叉搜索树的最近公共祖先
class CommonFatherTree_Solution {
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        
        if root == nil || p == nil || q == nil {
            
            return nil
        }
        var cur = root
        var arr:[TreeNode] = Array.init()
        while cur != nil {
            
            arr.append(cur!)
            if cur!.val > p!.val {
                
                cur = cur!.left
            }else if cur!.val < p!.val{
                
                cur = cur?.right
            }else{
                
                break;
            }
        }
        
        var cur2 = root
        var arr2:[TreeNode] = Array.init()
        while cur2 != nil {
            
            arr2.append(cur2!)
            if cur2!.val > q!.val {
                
                cur2 = cur2!.left
            }else if cur2!.val < q!.val{
                
                cur2 = cur2?.right
            }else{
                
                break;
            }
        }

        var index = 0
        var lastNode:TreeNode? = root!
        while index<arr.count && index<arr2.count {
            
            if arr[index] === arr2[index] {
                
                lastNode = arr[index]
            }else{
                
                break
            }
            index += 1
        }
        return lastNode
    }
}
