//
//  Protocol.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa


/// 定义输入输入类型
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

enum Result {
    case ok(message:String)
    case empty
    case failed(message:String)
}


extension Result {
    var isValid:Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension Result {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}
