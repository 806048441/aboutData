//
//  FineSearchTreeMinKNode.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/1.
//

import Foundation

//二叉搜索树中第K小的元素
class FineSearchTreeMinKNode_Solution {
    
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        
        if root == nil {
            
            return -1
        }
        var stk:[TreeNode] = Array.init()
        var cur = root
        var index = 1
        while (cur != nil || stk.count != 0) {
            
            while (cur != nil) {
                
                stk.append(cur!)
                cur = cur!.left;
            }
            cur = stk.removeLast();
            if index == k {
                
                return cur!.val
            }
            index += 1
            cur = cur?.right;
        }
        return index
    }
}
