//
//  SwiftLinkListProtocol.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/5/3.
//

import Foundation

protocol LinkListProtocol {
    
    associatedtype Element
    var size:Int { get  }
    func add(_ element:Element)
    func add(_ index:Int , _ element:Element)
    func clear()
    func remove()
    func remove(_ index:Int)
    func isEmpty() -> Bool
}
