//
//  MergeTwoLists.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/3/10.
//

import UIKit

class MergeTwoLists {
    
    //合并两个有序链表 easy
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        
        if list1 == nil {
            
            return list2
        }
        if list2 == nil {
            
            return list1
        }
        
        var inoutList1 = list1, inoutList2 = list2
        let lastNode = ListNode.init(-1)
        var cur = lastNode
        while inoutList1 != nil && inoutList2 != nil {
            
            if inoutList1!.val<inoutList2!.val {
                
                cur.next = inoutList1
                inoutList1 = inoutList1!.next
            }else{
                
                cur.next = inoutList2
                inoutList2 = inoutList2!.next
            }
            cur = cur.next!
        }
        cur.next = inoutList1 == nil ? inoutList2 : inoutList1
        return lastNode.next
    }
}
