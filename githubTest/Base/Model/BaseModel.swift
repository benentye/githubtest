//
//  BaseModel.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
//


import Foundation
import ObjectMapper
class BaseModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code    <- map["code"]
        data    <- map["data"]
        msg     <- map["msg"]
    }
    
    
    var code: Int?
    var data: [String : AnyObject]!
    var msg: String?
}
