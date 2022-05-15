//
//  CompareTreeIsEqu.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/6.
//

import UIKit

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class CompareTreeIsSame {
    
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        
        if (p == nil && q == nil) {
            
            return true
        }
        if (p == nil || q == nil){
            
            return false
        }
        var result = true
        var queue1:[TreeNode] = Array.init()
        var queue2:[TreeNode] = Array.init()
        queue1.append(p!)
        queue2.append(q!)
        while (queue1.count != 0 || queue2.count != 0){
            
            if queue1.count != queue2.count {
                
                result = false
                break
            }else{
                
                let cur1 = queue1.removeFirst()
                let cur2 = queue2.removeFirst()
                if cur1.val != cur2.val{
                    
                    result = false
                    break
                }else{
                    
                    if cur1.left != nil {
                        
                        if cur2.left == nil {
                            
                            result = false
                            break
                        }
                        queue1.append(cur1.left!)
                    }
                    
                    if cur1.right != nil {
                        
                        if cur2.right == nil {
                            
                            result = false
                            break
                        }
                        queue1.append(cur1.right!)
                    }
                    
                    if cur2.left != nil {
                        
                        if cur1.left == nil {
                            
                            result = false
                            break
                        }
                        queue2.append(cur2.left!)
                    }
                    
                    if cur2.left != nil {
                        
                        if cur1.right == nil {
                            
                            result = false
                            break
                        }
                        queue2.append(cur2.right!)
                    }
                    
                }
            }
        }
        
        return result
    }
}

