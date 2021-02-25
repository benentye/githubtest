//
//  CommonBaseNetWorkBase.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
// y弃用

//


import Foundation
import RxSwift
import Moya
import ObjectMapper
import CLToast
import Moya_ObjectMapper


///初始化请求的provider
let CommonBaseNetWorkBase = MoyaProvider<CommonBase>()


///请求分类
public enum CommonBase {
    case apiGitHub
}

///请求配置
extension CommonBase: TargetType {
    ///服务器地址
    public var baseURL: URL {
        return URL(string: BaseUrl)!
    }
    
    
    ///请求的具体路径
    public var path: String {
        switch self {
        case .apiGitHub:
            return "/"
            
            
        }
        
        
    }
    ///请求类型
    public var method: Moya.Method {
        return .get
        
        
    }
    ///请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
            
            
        default:
            return .requestPlain
        }
        
    }
    
    ///是否执行Alamofire验证
    public var validate: Bool {
        return false
        
    }
    
    ///这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
        
    }
    
    ///请求头
    
    public var headers: [String: String]? {
        
        return nil
        
    }
}







//与数据相关的错误类型
enum DataError: Error {
    case abnormalAccount //账户异常需要重新登录
    case otherError //其它错误
}


struct defaultModel<T: Mappable>: Mappable {
    
    var code: Int?
    var data: T?
    var msg: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        code     <- map["code"]
        data     <- map["data"]
        msg      <- map["msg"]
    }
}

extension MoyaProvider {
    public func requestService<T: Mappable>(_ target : Target, _ model: T.Type) -> Single<T> {
        
        return Single<T>.create(subscribe: { (single) -> Disposable in
            
            let request = self.rx.request(target).mapObject(defaultModel<T>.self)
                .subscribe(onSuccess: { (result) in
                    
                    
                    //根据code值 来实现不同的操作
                    if result.code! == 0  {
                        single(.success(result.data!))
                    }
                    else
                    {
                        //提示msg
                        CLToast.cl_show(msg: result.msg!,onView: UIApplication.shared.keyWindow?.rootViewController?.view, success: true,duration: 2)
                    }
                    
                }) { (error) in
                    
                    print(error)
                    print(target.path)
                    single(.error(DataError.otherError))
                    
            }
            return Disposables.create([request])
        })
        
    }
    
}




