//
//  ArrayToBinarySearchTree.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/31.
//

import Foundation


/// 108. 将有序数组转换为二叉搜索树

class Solution_ArrayToBinarySearchTree {
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        
        if nums.count == 0 {
            
            return nil
        }
        if nums.count == 1 {
            
            return TreeNode.init(nums.first!)
        }
        
        let index = nums.count/2
        let num = nums[index]
        let left = Array(nums[0..<index])
        var right:[Int] = Array.init()
        if nums.count > index+1 {
            
            right = Array(nums[index+1..<nums.count])
        }
        let node = TreeNode.init(num, sortedArrayToBST(left), sortedArrayToBST(right))
        return node
    }
}
