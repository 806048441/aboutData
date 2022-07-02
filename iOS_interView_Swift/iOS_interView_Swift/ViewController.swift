//
//  ViewController.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2021/12/24.
//

import UIKit
//import iOS_interView_Swift_demo_Target
//import SwiftyJSON


enum MyEnum:String,CaseIterable{
    
    case one = "normal"
    case two = "fuck"
    case three = "lazy"
}

extension String {
    
    var realRowValue:String {
        
        for c in MyEnum.allCases {
            
            if self == c.rawValue {
                
                return c.rawValue
            }
        }
        return MyEnum.one.rawValue
    }
}
@propertyWrapper
struct Max18 {
    
    private var number = 0
    var wrappedValue:Int {
        
        set {
            
            number = min(newValue, 18)
        }
        get {
            
            return number
        }
    }
}

struct MyPerson {
    
    let name = "name"
    var height = 30.0
    var age = 90
    static func clsTest() {
        
    }
    
    mutating func insTest () {
        
        self.height = 10
    }
    
    subscript (index:String) -> String {
        
        get {
            
            return "index" + "=\(index)"
        }
    }
}

struct MyChild {
    
    @Max18 var age:Int
}

class MyPersonClass {
    
    let name :String
    var height = 30.0
    final var age = 14
    static let className = "className"
    static var fuckName = "fuckName"
    lazy var totalData = String()
    
    init (height:Double,name:String) {
        
        self.height = height
        self.name = name
    }
    
    init () {
        
        self.name = "initName"
    }
    
    static func clsTest() {
        
    }
    
    func insTest() {
        
        print("this is personCls intTest");
    }
    
    func request(byUrl url:String, cmd:String, callBack:((String) -> ())) {
        
        callBack(url+"/\(cmd)")
    }
    
    func someFunctionThatTakesAClosure(closure: (String) -> Void) {
        // 函数体部分
    }
    
    func someFunctionThatTakesAClosure2(closure: () -> Int) {
        // 函数体部分
    }
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    
    var completionHandlers: [() -> Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
}

class MyChildClass : MyPersonClass {
    
    let cookie: String
    
    var toy:Toy?
    
    init(_ cookie:String) {
        
        self.cookie = cookie
        super.init(height: 10, name: "name")
        self.height = 30
    }
    
    override func insTest() {
        
        print("this is childCls intTest");
    }
    
    deinit {
        print("deinit")
    }
}

enum ToyMaterial {
    
    case plastic
    case wood
    case iron
}

class Toy {
    
    var name = "toy name"
    var material = ToyMaterial.plastic
    
    func getToyAllInfo() -> String {
        
        return "name=\(self.name)\nmaterial=\(self.material)"
    }
}

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        OfferII103_Solution.init().coinChange([1,2,5], 11)
        
        var array:[Int8?] = [Int8].init(repeating: 0, count: 10)

        print(withUnsafePointer(to: &array) {ptr in print(ptr)})

        print("start-")

        for index in 0...array.count-1 {
            
            print(withUnsafePointer(to: &array[index]) {ptr in print(ptr)})
        }
        print("-end")

        Solution.init().isAnagram("anagram", "nagaram")
        
        //        let data = MakeNums.makeIntRandomNums(1, 10000, 5000)
        //
        //        let data2 = MakeNums.makeIntAscSortNums(1, 10000)
        //
        //        TimeDetection.printMethodExcuteTime("bubbleSort1") {
        //
        //            let result = BubbleSort.bubbleSort1(data)
        //        }
        //
        //        TimeDetection.printMethodExcuteTime("bubbleSort2") {
        //
        //            let result = BubbleSort.bubbleSort2(data)
        //        }
        
        //        TimeDetection.printMethodExcuteTime("bubbleSort3") {
        //
        //            let result = BubbleSort.bubbleSort3(data)
        //        }
        
        //        TimeDetection.printMethodExcuteTime("bubbleSort1") {
        //
        //            let result = BubbleSort.bubbleSort1(data2)
        //        }
        //
        //        TimeDetection.printMethodExcuteTime("bubbleSort2") {
        //
        //            let result = BubbleSort.bubbleSort2(data2)
        //        }
        //
        //        TimeDetection.printMethodExcuteTime("bubbleSort3") {
        //
        //            let result = BubbleSort.bubbleSort3(data2)
        //        }
        
        //        TimeDetection.printMethodExcuteTime("selectionSort1") {
        //
        //            SelectionSort.selectionSort1(data)
        //        }
        //
        //        TimeDetection.printMethodExcuteTime("selectionSort2") {
        //
        //            SelectionSort.selectionSort2(data)
        //        }
        //
        //        TimeDetection.printMethodExcuteTime("selectionSort3") {
        //
        //            SelectionSort.selectionSort3(data)
        //        }
        
        //        TimeDetection.printMethodExcuteTime("HeapSort") {
        //
        //
        //
        //        }
        
    }
    
    func personSortTest1() -> () {
        
        var arr:[MyPerson] = Array.init()
        let person11 = MyPerson.init(height: 10, age: 1)
        let person22 = MyPerson.init(height: 30, age: 3)
        let person33 = MyPerson.init(height: 20, age: 2)
        arr.append(person11)
        arr.append(person22)
        arr.append(person33)
    }
    
    func binaryTreeTest1() -> () {
        
        let tree2 = BinarySearchTree<Int>.init()
        for _ in 0..<10 {
            
            let num = Int(arc4random()%100)
            print(num)
            tree2.add(num)
        }
        tree2.add(20)
        print("\n")
        
        tree2.postOrderTraverseNode(tree2.root) { value in
            
            print(value)
            if value == 20 {
                
                return true
            }
            return false
        }
    }
}


class Solution {
 
    func minimumDifference(_ nums: [Int], _ k: Int) -> Int {
        
        if k<=1 {
            
            return 0
        }
        let sortNums = nums.sorted()
        var minValue = sortNums[sortNums.count-1]
        for index in 0..<sortNums.count+1-k{
            
            minValue = min(minValue, sortNums[index-1+k]-sortNums[index])
        }
        return minValue
    }
    
    func countKDifference(_ nums: [Int], _ k: Int) -> Int {
        
        var count = 0
        for i in 0..<nums.count {
            
            for j in i+1..<nums.count {
                
                if abs(nums[i]-nums[j]) == k {
                    
                    count += 1
                }
            }
        }
        return count
    }
    
    func findMedianSortedArrays2(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        
        var arr:[Int] = Array.init()
                
        let arr2:[Int]=arr.sorted()
        let size:Int = arr2.count
        if size%2==0 {
            
            return Double((arr2[size/2-1]+arr2[size/2]))/2.0
        }else{
            
            return Double(arr2[size/2])
        }
    }
    
    func removePalindromeSub(_ s: String) -> Int {
        
        var isCould = true
        for i in 0..<s.count/2 {
            
            if s[s.index(s.startIndex, offsetBy: i)] != s[s.index(s.startIndex, offsetBy: s.count-i-1)] {
                
                isCould = false
            }
        }
        
        return isCould ? 1 : 2
    }
    
    func stoneGameIX(_ stones: [Int]) -> Bool {
        
        var hasZero = false
        var oneCount = 0
        var twoCount = 0
        for number in stones {
            
            let n = number%3
            switch n {
                
            case 1:
                
                oneCount += 1
            case 2:
                
                twoCount += 1
            default:
                
                hasZero = !hasZero
            }
        }
        
        if (!hasZero) {
            
            return oneCount >= 1 && twoCount >= 1;
        }
        return oneCount - twoCount > 2 || twoCount - oneCount > 2;
    }
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        
        let equ:Bool = (dividend>0 && divisor>0) || (dividend<0 && divisor<0)
        var first = abs(dividend)
        let second = abs(divisor)
        if second>first {
            
            return 0
        }else{
            
            var s = 0
            while first>=second {
                
                first -= second
                s+=1
            }
            
            s = equ ? s : -s
            let min = Int(truncating: pow(-2, 31) as NSNumber)
            let max = Int(truncating: pow(2, 31) - 1 as NSNumber)
            s = s < min ? min : s
            s = s > max ? max : s
            return s
        }
    }
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        return  Array(Set(nums1).intersection(nums2))
    }
    
    
    //    func maxSubArray(_ nums: [Int]) -> Int {
    //
    //        var last = Int.min
    //        var index = 0
    //        while index < nums.count {
    //
    //            if nums[index] <= 0 {
    //
    //                nums.removeFirst()
    //            }
    //        }
    //
    //        return last
    //    }
    
    func findCenter(_ edges: [[Int]]) -> Int {
        
        var last:Int?
        let cur:[Int] = edges[0]
        let next:[Int] = edges[1]
        last = Array(Set(cur).intersection(Set(next))).first
        return last!
    }
    
    func searchInsert2(_ nums: [Int], _ target: Int) -> Int {
        
        var mid = nums.count>>1
        var index = nums.count
        var left = 0
        var right = nums.count-1
        
        while left <= right {
            
            mid = (right - left)>>1 + left
            if target <= nums[mid]{
                
                index = mid
                right = mid - 1
            }else{
                
                left = mid + 1
            }
        }
        return index
    }
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        
        var mid:Int = nums.count>>1
        var left:Int = 0
        var right:Int = nums.count-1
        var last:Int = nums.count
        while (left <= right) {
            mid = ((right - left) >> 1) + left;
            if (target <= nums[mid]) {
                last = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return last
    }
    
    func romanToInt(_ s: String) -> Int {
        
        var value:Int = 0
        let dic:[Character:Int] = ["I":1,"V":5,"X":10,"L":50,"C":100,"D":500,"M":1000]
        for i in 0..<s.count-1 {
            
            let key = s[s.index(s.startIndex, offsetBy: i)]
            let nextKey = s[s.index(s.startIndex, offsetBy: i+1)]
            if dic[key]! < dic[nextKey]! {
                
                value -= dic[key]!
            }else{
                
                value += dic[key]!
            }
        }
        
        let key = s[s.index(s.endIndex, offsetBy: -1)]
        value += dic[key]!
        
        return value
    }
    
    func areAlmostEqual(_ s1: String, _ s2: String) -> Bool {
        
        /**-----
         给你长度相等的两个字符串 s1 和 s2 。一次 字符串交换 操作的步骤如下：选出某个字符串中的两个下标（不必不同），并交换这两个下标所对应的字符。
         如果对 其中一个字符串 执行 最多一次字符串交换 就可以使两个字符串相等，返回 true ；否则，返回 false 。
         来源：力扣（LeetCode）
         链接：https://leetcode-cn.com/problems/check-if-one-string-swap-can-make-strings-equal
         著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。-----*/
        var dif = 0
        var difNum:[(firstC:Character,secondC:Character)] = []
        for (index,c1) in s1.enumerated() {
            
            let c2:Character = s2[s2.index(s2.startIndex, offsetBy: index)]
            if c1 != c2{
                
                dif += 1
                if dif > 2 { return false}
                difNum.append((c1,c2))
            }
        }
        
        if difNum.count == 1 { return false}
        else if difNum.count == 0 {return true}
        else { return difNum[0].firstC == difNum[1].secondC && difNum[0].secondC == difNum[1].firstC }
    }
    
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        
        var d:Dictionary = Dictionary<Int, [Int]>.init()
        for i in 0..<nums.count {
            
            let num:Int = nums[i]
            if d.keys.contains(num) {
                
                var indexPath:[Int] = d[num]!
                if indexPath[1] == -1{
                    indexPath[1] = i-indexPath[0]
                }else{
                    
                    indexPath[1] = i-indexPath[0] < indexPath[1] ? i-indexPath[0] : indexPath[1]
                }
                indexPath[0] = i
                d.updateValue(indexPath, forKey: num)
            }else{
                
                let indexPath:[Int] = [i,-1]
                d.updateValue(indexPath, forKey: num)
            }
        }
        
        var distance:Int = -1
        for key in d.keys {
            
            let indexPath:[Int] = d[key]!
            if indexPath[1] != -1 {
                
                if distance == -1 {
                    
                    distance = indexPath[1]
                }else{
                    
                    distance = indexPath[1] < distance ? indexPath[1]:distance
                }
            }
        }
        
        if distance == -1 {
            
            return false
        }
        return distance <= k
    }
    //    func longestPalindrome(_ s: String) -> String {
    //
    //        var tempHas:Dictionary = Dictionary<Character, Array<Int>>.init()
    //
    //        for i in 0...s.count-1 {
    //
    //            let c:Character = s[s.index(s.startIndex, offsetBy: i)]
    //            if tempHas.keys.contains(c){
    //
    //                var value:Array = tempHas[c]!
    //                value.append(i)
    //                tempHas[c] = value
    //            }else{
    //
    //                var value:Array = Array<Int>.init()
    //                value.append(i)
    //                tempHas.updateValue(value, forKey: c)
    //            }
    //        }
    //        var index:Int = 0
    //        while index<s.count-2{
    //
    //
    //        }
    //    }
    
    func longestPalindrome(_ s: String) -> Int {
        
        var tempHas:Dictionary = Dictionary<Character, Int>.init()
        for c in s {
            
            if tempHas.keys.contains(c){
                
                let value:Int = tempHas[c]!
                tempHas[c]=value+1
            }else{
                
                tempHas.updateValue(1, forKey: c)
            }
        }
        
        var hasSingle:Bool = false
        var ln:Int = 0
        for tab in tempHas {
            
            ln += tab.value/2*2
            if (tab.value%2==1 && hasSingle==false){
                
                hasSingle = true
            }
        }
        if hasSingle {
            
            ln += 1
        }
        
        return ln;
    }
    
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        
        var i:Int=0
        var c:Int=0
        if flowerbed.count == 1{
            
            c = flowerbed[0]==0 ?1:0
            return c>=n;
        }
        while i<flowerbed.count{
            
            let cur = flowerbed[i]
            if i==0{
                
                let next = flowerbed[i+1]
                if cur==0 && next==0{
                    c+=1
                    i+=1
                }
            }else if(i==flowerbed.count-1){
                
                let last = flowerbed[i-1]
                if cur==0 && last==0{
                    c+=1
                    i+=1
                }
            }else{
                
                let next = flowerbed[i+1]
                let last = flowerbed[i-1]
                if cur==0 && next==0 && last==0{
                    c+=1
                    i+=1
                }
            }
            i+=1
        }
        return c>=n
    }
    
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        
        let child:[Int]=g.sorted()
        let cookies:[Int]=s.sorted()
        var kid = 0
        var cook = 0
        while kid<child.count && cook<cookies.count{
            
            if cookies[cook]>=child[kid]{
                
                kid+=1
            }
            cook+=1
        }
        return kid
    }
    
    func findMinDifference(_ timePoints: [String]) -> Int {
        
        var temp:Array = Array<Int>.init()
        
        for s in timePoints {
            
            let hs:Array = s.components(separatedBy: ":")
            temp.append(Int(hs[0])!*60+Int(hs[1])!);
            temp.append((24+Int(hs[0])!)*60+Int(hs[1])!)
        }
        temp = temp.sorted()
        var dis:Int = 24*60
        var i:Int = 0
        while i<temp.count-1 {
            
            dis = min(temp[i+1]-temp[i], dis)
            if dis == 0{
                
                break
            }
            i+=1
        }
        return dis
    }
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        let arr:[Int]=nums1+nums2
        let arr2:[Int]=arr.sorted()
        let size:Int = arr2.count
        if size%2==0 {
            
            return Double((arr2[size/2-1]+arr2[size/2]))/2.0
        }else{
            
            return Double(arr2[size/2])
        }
    }
    
    func firstUniqChar(_ s: String) -> Int {
        
        var dic:[Character:(minIndex:Int,times:Int)] = Dictionary.init()
        let arr = Array(s)
        for index in 0...arr.count - 1{
            
            if dic.keys.contains(arr[index]) {

                var t = dic[arr[index]]!
                t.times  = t.times+1
                dic[arr[index]] = t
            }else{

                dic[arr[index]] = (index,1)
            }
        }
                
        var minIndex = -1
        for key in dic.keys  {

            let t = dic[key]
            if t!.times == 1 {

                minIndex = (minIndex == -1) ? t!.minIndex : ((minIndex > t!.minIndex) ? t!.minIndex : minIndex)
            }
        }
        
        return minIndex
    }
    
//    给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
//
//    注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            
            return false
        }
        
        let arrs = Array(s)
        let arrt = Array(t)
        var dics:[Character:Int] = Dictionary.init()
        var dict:[Character:Int] = Dictionary.init()
        for index in 0...arrs.count-1 {
            
            let keys = arrs[index]
            let keyt = arrt[index]
            if dics.keys.contains(keys) {
                
                dics[keys] = dics[keys]! + 1
            }else{
                
                dics[keys] = 1
            }
            
            if dict.keys.contains(keyt) {
                
                dict[keyt] = dict[keyt]! + 1
            }else{
                
                dict[keyt] = 1
            }
        }
        
        for key in dics.keys {
            
            if !dict.keys.contains(key) || dics[key] != dict[key] {
                
                return false
            }
        }
        return true
    }
    
//    给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
//    说明：本题中，我们将空字符串定义为有效的回文串。
//    示例 1:
//    输入: "A man, a plan, a canal: Panama"
//    输出: true
//    解释："amanaplanacanalpanama" 是回文串

//    func isPalindrome(_ s: String) -> Bool {
//
//        }
    
//    假设环境不允许存储 64 位整数（有符号或无符号）。
//    func reverse(_ x: Int) -> Int {
        
//        var isF = x < 0
//        var y = abs(x)
//        var arr:[Int] = Array.init()
//        while y/10>0 {
//
//            arr.insert(y%10, at: 0)
//            y = y/10
//        }
//        if y>0 {
//
//            arr.insert(y%10, at: 0)
//        }
//        var lastN = 0
//        let length = arr.count - 1
//        for index in 0...length {
//
//
//        }
//    }
    
//    给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。
//
//    请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。
//
//    注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。
//
//
//    示例 1：
//
//    输入：nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
//    输出：[1,2,2,3,5,6]
//    解释：需要合并 [1,2,3] 和 [2,5,6] 。
//    合并结果是 [1,2,2,3,5,6] ，其中斜体加粗标注的为 nums1 中的元素。

    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        if nums1.count == 0 {
            
            nums1 = nums2
        }
        if nums2.count == 0 {
            
            return
        }
        
        var index1 = 0
        var index2 = 0
        var newNums:[Int] = Array.init()
        while index1 < m && index2 < n {
            
            if nums1[index1] < nums2[index2] {
             
                newNums.append(nums1[index1])
                index1 += 1
            }else{
                
                newNums.append(nums1[index2])
                index2 += 1
            }
        }
        
        while index1 < m {
            
            newNums.append(nums1[index1])
            index1 += 1
        }
        
        while index2 < n {
            
            newNums.append(nums1[index2])
            index2 += 1
        }
        
        nums1 = newNums
    }
    
    func reverseString(_ s: inout [Character]) {
        
        
        var leftIndex = 0
        var rightIndex = s.count-1
        while rightIndex - leftIndex > 0 {
            
            let c = s[leftIndex]
            s[leftIndex] = s[rightIndex]
            s[rightIndex] = c
            leftIndex += 1
            rightIndex -= 1
        }
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        var dic:[Int:Int] = Dictionary.init()
        
        for index in 0...nums.count-1 {
            
            if dic.keys.contains(target-nums[index]) {
                
                return [dic[target-nums[index]]!,index]
            }else{
                
                dic[nums[index]] = index
            }
        }
        return []
    }
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        
        var dic:[Int:Int] = Dictionary.init()
        for num in nums {
            
            if dic.keys.contains(num) {
                
                return true
            }else {
                
                dic[num] = 1
            }
        }
        return false
    }
    
    func plusOne(_ digits: [Int]) -> [Int] {
        
        if digits.count == 0 {
            
            return []
        }
        
        var array = digits
        var index = array.count-1
        while index >= 0 {
            
            var num = array[index]
            num = num + 1
            if num != 10 {
                
                array[index] = num
                break
            }
            array[index] = 0
            if index == 0 {
                
                array.insert(1, at: 0)
            }
            index -= 1
        }
        
        return array
    }
    
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        var dic1:[Int:Int] = Dictionary.init()
        var dic2:[Int:Int] = Dictionary.init()
        
        for num1 in nums1 {
            
            if dic1.keys.contains(num1) {
                
                dic1[num1] = dic1[num1]!+1
            }else{
                
                dic1[num1] = 1
            }
        }
        
        for num2 in nums2 {
            
            if dic2.keys.contains(num2) {
                
                dic2[num2] = dic2[num2]!+1
            }else{
                
                dic2[num2] = 1
            }
        }
        
        var arr:[Int] = Array.init()
        
        for key in dic1.keys {
            
            if dic2.keys.contains(key) {
                
                let minTime = (dic1[key]! > dic2[key]!) ? dic2[key]! : dic1[key]!
                
                for _ in 0..<minTime {
                    
                    arr.append(key)
                }
            }
        }
        return arr
    }
    
    func singleNumber(_ nums: [Int]) -> Int {
        
        if nums.count<1 {
            
            return -1
        }
        if nums.count == 1 {
            
            return nums[0]
        }
        var arr = nums
        for index in 1...nums.count-1 {
            
            arr[0] = arr[0] ^ arr[index]
        }
        return arr[0]
        
        //        var dic:[Int:Int] = Dictionary.init()
        //
        //        for num in nums {
        //
        //            if dic.keys.contains(num) {
        //
        //                dic.removeValue(forKey: num)
        //            }else{
        //
        //                dic[num] = 1
        //   }
        //        }
        //        return dic.keys.first!
    }
    
    
//    func isValidSudoku(_ board: [[Character]]) -> Bool {
//
//        return checkRow(board) && checkColum(board) && check9Code(board)
//
//        func checkRow(_ board:[[Character]]) -> Bool {
//
//            for row in 0...8 {
//
//                let data = board[row]
//                var dic:[Character:Int] = Dictionary.init()
//                for colum in 0...8 {
//
//                    let c = data[colum]
//                    if c == "." {
//
//                        continue
//                    }
//                    if dic.keys.contains(c) {
//
//                        return false
//                    }else{
//
//                        dic[c] = 1
//                    }
//                }
//            }
//            return true
//        }
//
//        func checkColum(_ board:[[Character]]) -> Bool {
//
//            for colum in 0...8 {
//
//                var dic:[Character:Int] = Dictionary.init()
//                for row in 0...8 {
//
//                    let data = board[row]
//                    let c = data[colum]
//                    if c == "." {
//
//                        continue
//                    }
//                    if dic.keys.contains(c) {
//
//                        return false
//                    }else{
//
//                        dic[c] = 1
//                    }
//                }
//            }
//            return true
//        }
//
//        func check9Code(_ board:[[Character]]) -> Bool {
//
//            for colum in 0...8 {
//
//                var dic:[Character:Int] = Dictionary.init()
//                for row in 0...8 {
//
//                    let data = board[row]
//                    let c = data[colum]
//                    if c == "." {
//
//                        continue
//                    }
//                    if dic.keys.contains(c) {
//
//                        return false
//                    }else{
//
//                        dic[c] = 1
//                    }
//                }
//            }
//            return true
//        }
//    }
    
}
