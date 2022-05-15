//
//  File.swift
//  
//
//  Created by 神州第一坑 on 2022/1/24.
//

import Foundation


public class DemoPublicPerson {
    
    let name:String
    let age:Int
    let height:Double
    init(_ name:String,_ age:Int,_ height:Double) {
        
        self.name = name
        self.age = age
        self.height = height
    }
}

open class DemoOpenPerson {
    
    public let name:String
    let age:Int
    let height:Double
    init(_ name:String,_ age:Int,_ height:Double) {
        
        self.name = name
        self.age = age
        self.height = height
    }
}
