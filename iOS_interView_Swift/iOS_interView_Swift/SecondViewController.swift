//
//  SecondViewController.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/1/22.
//

import UIKit

public protocol ChangeColorDelegate {
    
    var delegateRoName:String {get}
    var delegateRwName:String {set get}
    func changeBackgroundColor(color:UIColor) -> Void
}

struct Stack<stackEle : UITableViewDelegate> : ChangeColorDelegate{
    
    var delegateRoName: String {
        
        return "g"
    }
    
    var delegateRwName: String {
        
        set {
            
        }
        
        get {
            
            return "f"
        }
    }
    
    func changeBackgroundColor(color: UIColor) {
        
    }
    
    var items: [stackEle] = []
    mutating func push(_ item: stackEle) {
        items.append(item)
    }
    mutating func pop() -> stackEle {
        return items.removeLast()
    }
}


class SecondViewController: UIViewController,UITableViewDelegate {
    
    var changeColorDelegate : ChangeColorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red

        var stack:Stack = Stack<UITableViewDelegate>.init()
        stack.push(self)
        stack.pop()
        
        
        var stack2:Stack = Stack<UITableViewDelegate>.init()
        stack2.push(self)
        stack2.pop()
        
    
        
        // Do any additional setup after loading the view.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.changeColorDelegate != nil {
            
            self.changeColorDelegate!.changeBackgroundColor(color: UIColor.blue)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        
        print("SecondViewController - deinit")
    }

}
