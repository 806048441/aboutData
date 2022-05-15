//
//  GetBinaryTreeHigh.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/6.
//

import UIKit

class GetBinaryTreeHigh {

    func maxDepth(_ root: TreeNode?) -> Int {
        
        if root == nil {
            
            return 0
        }
        var depth = 0
        var queue:[TreeNode] = Array.init()
        queue.append(root!)
        while queue.count != 0 {
            
            depth += 1
            let count = queue.count
            for index in 0..<count {
                
                let cur = queue.removeFirst()
                if cur.left != nil {
                    
                    queue.append(cur.left!)
                }
                if cur.right != nil {
                    
                    queue.append(cur.right!)
                }
            }
        }
        return depth
    }
}
