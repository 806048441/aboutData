//
//  OfferMaxKNums.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/7.
//

import UIKit

//剑指 Offer II 060. 出现频率最高的 k 个数字

class OfferMaxKNums_Solution {
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        
        if nums.count < k {
            
            return []
        }
        var hash:[Int:Int] = Dictionary.init()
        for num in nums {
            
            (hash.keys.contains(num)) ? (hash[num]! += 1) : (hash[num] = 1)
        }
        
        var arr:[Int] = Array.init()
        for data in hash {
            
            var left = 0
            var right = arr.count - 1
            var mid = (left+right)>>1
            var index = arr.count
            while left <= right {
                
                mid = ((right - left)>>1) + left
                let key:Int = arr[mid]
                if data.value == hash[key] {
                    
                    index = mid
                    break
                }else if data.value > hash[key]! {
                    
                    left = mid + 1
                }else{
                    
                    index = mid
                    right = mid - 1
                }
            }
            arr.insert(data.key, at: index)
        }
       
        
        if arr.count>=k {
            
            return Array(arr[arr.count-k-1..<arr.count])
        }
        return arr
    }
}

//剑指 Offer 03. 数组中重复的数字
class Offer03_Solution {
    
    func findRepeatNumber(_ nums: [Int]) -> Int {
        
        var hash:[Int:Int] = Dictionary.init()
        for num in nums {
            
            if hash.keys.contains(num) {
                
                return num
            }else{
                
                hash[num]=1
            }
        }
        
        return 0
    }
}

//剑指 Offer 04. 二维数组中的查找
class Offer04_Solution {
    
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
        
//        [1,   4,  7, 11, 15],
//        [2,   5,  8, 12, 19],
//        [3,   6,  9, 16, 22],
//        [10, 13, 14, 17, 24],
//        [18, 21, 23, 26, 30]
        
        if matrix.count == 0 || matrix[0].count == 0 {
            
            return false
        }
        
        var row = 0
        var colum = matrix[0].count-1
        
        while row<matrix.count && colum>=0 {
            
            if target == matrix[row][colum] {
                
                return true
            }else if target > matrix[row][colum] {
                
                row += 1
            }else{
                
                colum -= 1
            }
        }
        
        return false
        
     
//        for arr in matrix {
//
//            var left = 0
//            var right = matrix[0].count - 1
//            var mid = (left + right) >> 1
//
//            while left <= right {
//
//                mid = (right-left)>>1 + left
//                if target == arr[mid] {
//
//                    return true
//                }else if (target > arr[mid]){
//
//                    left = mid + 1
//                }else{
//
//                    right = mid - 1
//                }
//            }
//        }
//
//        return false
    }
}

//剑指 Offer 11. 旋转数组的最小数字
class Offer11_Solution {
    
    func minArray(_ numbers: [Int]) -> Int {
              
        if numbers.count == 1 {
            
            return numbers[0]
        }
        
        var left = 0
        var right = numbers.count-1
        var mid = (left+right)>>1 //1
        
        while left<=right {
            
            mid = (right-left)>>1 + left
            if numbers[mid] < numbers[right] {
                
                right = mid
            }else if numbers[mid] > numbers[right]{
                
                left = mid + 1
            }else{
                
                right = right - 1
            }
        }
        return numbers[left]
    }
}

//剑指 Offer 05. 替换空格
class Offer05_Solution {
    
    func replaceSpace(_ s: String) -> String {
        
        var string:String = ""
        
        for c in s {
            
            string = (c == " ") ? (string+"%20") : (string+String(c))
        }
        
        return string
    }
}

//剑指 Offer 07. 重建二叉树 现在是错的 还得再看再改
class Offer07_Solution {
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        
        if inorder.count == 0 {

            return nil
        }

        var preNums = preorder

        var root:TreeNode?
        let rootVal = preNums.removeFirst();
        let index = inorder.firstIndex(of: rootVal)

        var lefts:[Int]? = nil
        var rights:[Int]? = nil
        if index != nil && index! > 0 {

            lefts = Array(inorder[0..<index!])
        }
        if index != nil && index!+1 < inorder.count {

            rights = Array(inorder[index!+1..<inorder.count])
        }

        var left:TreeNode?
        var right:TreeNode?
        if lefts != nil && lefts!.count > 0 {

            left = buildTree(preNums, lefts!)
            preNums.removeFirst()
        }
        if rights != nil && rights!.count>0 {

            right = buildTree(preNums, rights!)
//            preNums.removeFirst()
        }
        root = TreeNode.init(rootVal, left, right)
        return root
    }
}

//剑指 Offer 26. 树的子结构
class Offer26_Solution {
    
    func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        
        if B == nil {
            
            return false
        }
        if A == nil {
            
            return false
        }
        
        var queue:[TreeNode] = Array.init()
        queue.append(A!)
        while !queue.isEmpty {
            
            let a_node = queue.removeFirst()
            if a_node.val == B!.val {
                
                let result = AIsContansB(a_node, B!)
                if result {
                    
                    return result
                }
            }
            
            if a_node.left != nil {
                
                queue.append(a_node.left!)
            }
            if a_node.right != nil {
                
                queue.append(a_node.right!)
            }
        }
       
        return false
    }
    
    func AIsContansB(_ A:TreeNode,_ B:TreeNode) -> Bool {
        
        var a_queue:[TreeNode] = Array.init()
        var b_queue:[TreeNode] = Array.init()
        a_queue.append(A)
        b_queue.append(B)
        while !b_queue.isEmpty {
            
            let a_node = a_queue.removeFirst()
            
            let b_node = b_queue.removeFirst()

            if (a_node.val != b_node.val) {

                return false
            }

            if b_node.left != nil {

                b_queue.append(b_node.left!)
            }
            if b_node.right != nil {

                b_queue.append(b_node.right!)
            }
            
            if a_node.left != nil {

                a_queue.append(a_node.left!)
            }
            if a_node.right != nil {

                a_queue.append(a_node.right!)
            }
            if a_queue.isEmpty && !b_queue.isEmpty {

                return false
            }
        }
        
        return true
    }
}

//剑指 Offer 27. 二叉树的镜像
class Offer27_Solution {
    
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        
        if root == nil {
            
            return root
        }
        
        var queue:[TreeNode] = Array.init()
        queue.append(root!)
        while !queue.isEmpty {
            
            let cur = queue.removeFirst()
            let tmp = cur.left
            cur.left = cur.right
            cur.right = tmp
            if cur.left != nil {
                
                queue.append(cur.left!)
            }
            if cur.right != nil {
                
                queue.append(cur.right!)
            }
        }
        return root
    }
}

//剑指 Offer 40. 最小的k个数
class Offer40_Solution{
    
    func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
        
        if arr.count < k {
            
            return arr
        }
        let heap = MinHeap.init(arr)
        var res = Array<Int>.init()
        var index = 0
        while index < k {
            
            res.append(heap.remove()!)
            index += 1
        }
        return res
    }
}

//剑指 Offer 21. 调整数组顺序使奇数位于偶数前面
class Offer21_Solution {
    
    func exchange(_ nums: [Int]) -> [Int] {
        
        if nums.count == 0 {
            
            return nums
        }
        var arr1:[Int] = Array.init()
        for index in 0...nums.count-1 {
            
            if nums[index]%2==1 {
                
                arr1.append(nums[index])
            }
        }
        
        for index in 0...nums.count-1 {
            
            if nums[index]%2==0 {
                
                arr1.append(nums[index])
            }
        }
        return arr1
    }
}

//剑指 Offer 28. 对称的二叉树
class Offer28_Solution {
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        return checkIsSy(root, root)
    }
    
    func checkIsSy(_ p: TreeNode? , _ q:TreeNode?) -> Bool {
        
        if p == nil && q == nil {
            
            return true
        }
        if p == nil || q == nil {
            
            return false
        }
        return p?.val == q?.val && checkIsSy(p?.left, q?.right) && checkIsSy(p?.right, q?.left)
    }
}

//剑指 Offer II 078. 合并排序链表
class OfferII78_Solution {
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        let heap = Min78Heap.init(lists)
        let root:ListNode = ListNode.init()
        var cur = root
        while heap.top() != nil {
            
            cur.next = ListNode.init(heap.remove()!)
            cur = cur.next!
        }
        return root.next
    }
}

class Min78Heap {
    
    var dt:[ListNode] = Array.init()
    
    var size: Int {
        
        get {
            
            return self.dt.count
        }
    }
    
    convenience init() {
        
        self.init([])
    }
    
    init(_ elements:[ListNode?]) {
        
        if elements.count>0 {
            
            for index in 0...elements.count-1 {
                
                if elements[index] != nil {
                    
                    self.add(elements[index]!)
                }
            }
        }
    }
    
    func isEmpty() -> Bool {
        
        return self.size == 0
    }
    
    func clear() -> () {
        
        dt.removeAll()
    }
    
    func add(_ element:ListNode) -> () {
        
        self.dt.append(element)
        self.siftUp(self.size-1)
    }
 
    
    func top() -> Int? {
        
        return self.isEmpty() ? nil : self.dt.first?.val
    }
    
    func remove() -> Int? {
        
        if self.isEmpty() {
            
            return nil
        }
        var removeElement = self.dt[0]
        let val = removeElement.val
        if removeElement.next != nil {
            
            removeElement = removeElement.next!
        }else{
            
            self.dt[0] = self.dt.last!
            self.dt[self.size-1] = removeElement
            self.dt.removeLast()
        }
        self.siftDown(0)
        return val
    }
    
    private func siftUp(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        while opIndex > 0 {
            
            let parentIndex = (opIndex-1) >> 1
            let parentElement = self.dt[parentIndex]
            if siftElement.val > parentElement.val  {
                
                break
            }
            self.dt[opIndex] = parentElement
            opIndex = parentIndex
        }
        self.dt[opIndex] = siftElement
    }
    
    private func siftDown(_ index:Int) {
        
        var opIndex = index
        let siftElement = self.dt[opIndex]
        let half = self.size >> 1
        while opIndex < half  {
            
            var childIndex = (opIndex<<1) + 1
            var child = self.dt[childIndex]
            let rightChildIndex = childIndex + 1
            if rightChildIndex < self.size && self.dt[rightChildIndex].val < child.val {
                
                childIndex = rightChildIndex
                child = self.dt[rightChildIndex]
            }
            if siftElement.val < child.val {
                
                break
            }
            self.dt[opIndex] = child
            opIndex = childIndex
        }
        self.dt[opIndex] = siftElement
    }
}

//剑指 Offer II 077. 链表排序
class OfferII77_Solution {
    
    func sortList(_ head: ListNode?) -> ListNode? {

        var array:[Int] = Array.init()
        var cur = head
        while cur != nil {
            
            var left = 0
            var right = array.count-1
            var index = array.count
        
            while left <= right {
                
                let mid = (left+right)>>1
                if cur!.val == array[mid] {
                    
                    index = mid
                    break
                }else if cur!.val > array[mid] {
                    
                    left = mid + 1
                }else{
                    
                    index = mid
                    right = mid - 1
                }
            }
            array.insert(cur!.val, at: index)
            cur = cur!.next
        }
        
        let newHead = ListNode.init()
        var opHead = newHead
        for num in array {
            
            opHead.next = ListNode.init(num)
            opHead = opHead.next!
        }
        return newHead.next
    }
}

//剑指 Offer II 024. 反转链表
class OfferII24_Solution {

    func reverseList(_ head: ListNode?) -> ListNode? {

        var cur = head
        var prev:ListNode? = nil
        while cur != nil {

            let temp = cur?.next
            cur?.next = prev
            prev = cur
            cur = temp
        }
        return prev
    }
}

//剑指 Offer 10- I. 斐波那契数列
class SolutionOffer10_I {
    
//    70. 爬楼梯
    
    func climbStairs(_ n: Int) -> Int {

        if n==1 {
            return 1
        }
        if n==2 {
            return 2
        }
        
        var first = 1
        var second = 2
        for _ in 3...n {
            
            second = first + second
            first = second - first
        }
        return second
    }
    
    func fib(_ n: Int) -> Int {
        
        if n == 0 {
            
            return 0
        }
        if n <= 2 {
            
            return 1
        }
        var first = 1
        var second = 1
        for _ in 3...n {
            
            first = first%1000000007
            second  = second%1000000007
            second = (first + second)
            first = (second - first)
        }
        return second%1000000007
    }
}

//剑指 Offer II 081. 允许重复选择元素的组合
class OfferII81_Solution {
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {

    }
    
    func backtracking(_ candidates: [Int]) -> <#return type#> {
        <#function body#>
    }
}
