//
//  CommonBaseViewModel.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
//

import Foundation
import Alamofire
protocol CommonBaseViewModelDelegate: class {
    func updateResult(_ firstOrnot:Bool,_ data: NSDictionary)
    
}
public class CommonBaseViewModel{
    weak var delegate: CommonBaseViewModelDelegate? {
        didSet {
        }
    }
    
    
    var countdownCurNum:Int = 5
    var countdownTimer:Timer!
    
    /// 网络请求:
    /// - Parameter
    func apiGitHub(_ firstOrnot:Bool) {
        var request = URLRequest(url: NSURL.init(string: BaseUrl)! as URL)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue( "application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(request).responseJSON
            { (response) in
                if response.error == nil {
                    
                    let  data =   response.result.value as! NSDictionary
//                    print(data)
                    
                    self.delegate?.updateResult(firstOrnot,data)

                }else{
                    print("Post 请求失败：\(response.error ?? "" as! Error)")
                }
        }
    }
    
    /// 计时开始
    func startCountdown() {
        
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        
    }
    
    /// 计时动作
    @objc func updateCountdown() {
        print("updateCountdown:\(Date())")
        apiGitHub(false)
    }
    
    
    /// 结束计时
    func stopCountdown(){
        print("stopCountdown")
        if self.countdownTimer != nil {
            self.countdownTimer.invalidate()
        }
        
    }
    
    func clearTimer()
    {
        stopCountdown()
    }
    
}


