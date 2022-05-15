//
//  TimeTest.swift
//  iOS_interView_Swift
//
//  Created by 神州第一坑 on 2022/4/16.
//

import Foundation


class TimeDetection {
    
    static func printMethodExcuteTime (_ identifier:String , _ excute:(()->Void)) -> (){
        
        let begin = CFAbsoluteTimeGetCurrent()
        excute()
        let end = CFAbsoluteTimeGetCurrent()
        print(identifier + "耗时：" + String(end - begin) + "秒")
    }
}
