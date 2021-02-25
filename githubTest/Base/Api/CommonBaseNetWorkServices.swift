//
//  CommonBaseNetWorkServices.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
//

import Foundation
import RxSwift

/// 网络请求
/// - Parameters:
///   - token:
///   - model:
func apiGitHub(_ model: BaseModel.Type)-> Single<BaseModel> {
    
    return Single<BaseModel>.create(subscribe: { (single) -> Disposable in
        let verifyLogin = CommonBaseNetWorkBase.requestService(.apiGitHub, model.self).subscribe(onSuccess: { (model) in
            
            
            single(.success(model))
            
        }) { (error) in
            print(error)
        }
        return Disposables.create([verifyLogin])
        
    })
}
