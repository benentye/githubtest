//
//  config.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
//

import Foundation

///设置环境变量
var ApiType = 1


func getApiHost() -> String {
    
    let Api:String
    switch ApiType {
    case 1:
        Api = "https://api.github.com"
        break
    default:
        Api = "https://api.github.com"
        break
    }
    
    return Api
}

/// 设置BaseUrl常量方便调用
let BaseUrl = getApiHost()
